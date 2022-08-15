`ifndef RKV_GPIO_MASKED_ACCESS_VIRT_SEQ_SV
`define RKV_GPIO_MASKED_ACCESS_VIRT_SEQ_SV


class rkv_gpio_masked_access_virt_seq extends rkv_gpio_base_virtual_sequence;
  `uvm_object_utils(rkv_gpio_masked_access_virt_seq)

  function new (string name = "rkv_gpio_masked_access_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    repeat(10) begin
      set_and_check_masked_access(0);//via address
      set_and_check_masked_access(1);//via rgm
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask


  task set_and_check_masked_access(bit via_rgm = 0);
    logic [15:0] portout_reg_write, portout_port_mon, maskbyte_reg_write, portout_expected, maskbyte_reg_read, portin_port_drv;
    bit [15:0] mask;
    bit [15:0] addr_masklowbyte, addr_maskhighbyte;
    uvm_status_e status;
    std::randomize(portout_reg_write, mask, maskbyte_reg_write, portin_port_drv); 

    //check PORTOUT
    set_portout_bits(portout_reg_write);
    //one-cycle from io-bridge to portout
    wait_cycles(2);
    portout_port_mon = vif.portout;
    compare_data(portout_reg_write, portout_port_mon);

    //calculate addr
    addr_masklowbyte = RKV_ROUTER_REG_ADDR_MASKLOWBYTE + (mask[7:0] << 2);
    addr_maskhighbyte = RKV_ROUTER_REG_ADDR_MASKHIGHBYTE + (mask[15:8] << 2);

    //set MASKLOWBYTE and MASKHIGHBYTE
    if(!via_rgm) begin
      write_reg_with_addr(addr_masklowbyte, maskbyte_reg_write & 16'h00FF);
      write_reg_with_addr(addr_maskhighbyte, maskbyte_reg_write & 16'hFF00);
    end
    else begin
      rgm.MASKLOWBYTE[mask[7:0]].write(status, maskbyte_reg_write & 16'h00FF);
      rgm.MASKHIGHBYTE[mask[15:8]].write(status, maskbyte_reg_write & 16'hFF00);
    end

    //check PORTOUT w/wo MASKED-BYTE
    wait_cycles(2);
    foreach(portout_expected[i]) portout_expected[i] = mask[i] ? maskbyte_reg_write[i] : portout_reg_write[i];
    compare_data(vif.portout, portout_expected);

    //check read addr value from MASKED-BYTE
    vif.portin = portin_port_drv;
    wait_cycles(4);
    if(!via_rgm) begin
      read_reg_with_addr(addr_masklowbyte, maskbyte_reg_read);
      compare_data(maskbyte_reg_read, portin_port_drv & mask & 16'h00FF);
      read_reg_with_addr(addr_maskhighbyte, maskbyte_reg_read);
      compare_data(maskbyte_reg_read, portin_port_drv & mask & 16'hFF00);
    end
    else begin
      rgm.MASKLOWBYTE[mask[7:0]].read(status, maskbyte_reg_read);
      compare_data(maskbyte_reg_read, portin_port_drv & mask & 16'h00FF);
      rgm.MASKHIGHBYTE[mask[15:8]].read(status, maskbyte_reg_read);
      compare_data(maskbyte_reg_read, portin_port_drv & mask & 16'hFF00);
    end    
  endtask

endclass


`endif 
