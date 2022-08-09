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
      set_and_check_masked_access();
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask


  task set_and_check_masked_access();
    logic [15:0] pout_wr, pout_mo, pout_mk, pout_exp, pout_mrd;
    bit [15:0] mask;
    bit [15:0] addr_masklowbyte, addr_maskhighbyte; 
    std::randomize(pout_wr, mask, pout_mk); 

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
    write_reg_with_addr(addr_masklowbyte, pout_mk & 16'h00FF);
    write_reg_with_addr(addr_maskhighbyte, pout_mk & 16'hFF00);

    //check PORTOUT w/wo MASKED-BYTE
    wait_cycles(2);
    foreach(pout_exp[i]) pout_exp[i] = mask[i] ? pout_mk[i] : pout_wr[i];
    compare_data(vif.portout, pout_exp);

    //check read addr value from MASKED-BYTE
    //read_reg_with_addr(addr_masklowbyte, pout_mrd);
    //compare_data(pout_mrd, pout_mk & mask & 16'h00FF);
    //read_reg_with_addr(addr_masklowbyte, pout_mrd);
    //compare_data(pout_mrd, pout_mk & mask & 16'h00FF);

  endtask

endclass


`endif 
