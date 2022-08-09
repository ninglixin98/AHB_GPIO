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
    logic [15:0] pout_wr, pout_mo, pout_mk, pout_exp, pout_mrd, pin_mk;
    bit [15:0] mask;
    bit [15:0] addr_masklowbyte, addr_maskhighbyte;
    uvm_status_e status;
    std::randomize(pout_wr, mask, pout_mk, pin_mk); 

    //check PORTOUT
    set_portout_bits(pout_wr);
    //one-cycle from io-bridge to portout
    wait_cycles(2);
    pout_mo = vif.portout;
    compare_data(pout_wr, pout_mo);

    //calculate addr
    addr_masklowbyte = RKV_ROUTER_REG_ADDR_MASKLOWBYTE + (mask[7:0] << 2);
    addr_maskhighbyte = RKV_ROUTER_REG_ADDR_MASKHIGHBYTE + (mask[15:8] << 2);

    //set MASKLOWBYTE and MASKHIGHBYTE
    if(!via_rgm) begin
      write_reg_with_addr(addr_masklowbyte, pout_mk & 16'h00FF);
      write_reg_with_addr(addr_maskhighbyte, pout_mk & 16'hFF00);
    end
    else begin
      rgm.MASKLOWBYTE[mask[7:0]].write(status, pout_mk & 16'h00FF);
      rgm.MASKHIGHBYTE[mask[15:8]].write(status, pout_mk & 16'hFF00);
    end

    //check PORTOUT w/wo MASKED-BYTE
    wait_cycles(2);
    foreach(pout_exp[i]) pout_exp[i] = mask[i] ? pout_mk[i] : pout_wr[i];
    compare_data(vif.portout, pout_exp);

    //check read addr value from MASKED-BYTE
    vif.portin = pin_mk;
    wait_cycles(4);
    if(!via_rgm) begin
      read_reg_with_addr(addr_masklowbyte, pout_mrd);
      compare_data(pout_mrd, pin_mk & mask & 16'h00FF);
      read_reg_with_addr(addr_maskhighbyte, pout_mrd);
      compare_data(pout_mrd, pin_mk & mask & 16'hFF00);
    end
    else begin
      rgm.MASKLOWBYTE[mask[7:0]].read(status, pout_mrd);
      compare_data(pout_mrd, pin_mk & mask & 16'h00FF);
      rgm.MASKHIGHBYTE[mask[15:8]].read(status, pout_mrd);
      compare_data(pout_mrd, pin_mk & mask & 16'hFF00);
    end    
  endtask

endclass


`endif 
