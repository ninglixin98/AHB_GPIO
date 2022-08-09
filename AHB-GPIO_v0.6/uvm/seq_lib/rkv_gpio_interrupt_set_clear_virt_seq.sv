`ifndef RKV_GPIO_INTERRUPT_SET_CLEAR_VIRT_SEQ_SV
`define RKV_GPIO_INTERRUPT_SET_CLEAR_VIRT_SEQ_SV


class rkv_gpio_interrupt_set_clear_virt_seq extends rkv_gpio_base_virtual_sequence;
  `uvm_object_utils(rkv_gpio_interrupt_set_clear_virt_seq)

  function new (string name = "rkv_gpio_interrupt_set_clear_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    bit [3:0] int_num;
    bit [15:0] set_bits;
    bit bit_pattern[$] = {0, 1};
    RKV_INT_POL_T intpol;
    RKV_INT_TYPE_T inttype;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    for(int i = 0; i < 16; i++) begin
      foreach(bit_pattern[j]) begin
        set_bits = bit_pattern[j] << i;
        set_inttypeset(set_bits, i);
        inttype = RKV_INT_TYPE_T'(bit_pattern[j]);
        foreach(bit_pattern[k]) begin
          set_bits = bit_pattern[k] << i;
          set_intpolset(set_bits, i);
          intpol = RKV_INT_POL_T'(bit_pattern[k]);
          int_set_and_check(i, inttype, intpol);
        end
      end
    end
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

  task int_set_and_check(int id, RKV_INT_TYPE_T inttype, RKV_INT_POL_T intpol);
    // TODO
    bit [15:0] set_bits;
    set_bits = 1'b1 << id;
    case({inttype, intpol})
      {ACTIVE_LEVEL, ACTIVE_LOW}: begin
        vif.portin[id] <= 1'b1;
        wait_cycles(10, CLK_FCLK);
        vif.portin[id] <= 1'b0;
      end
      {ACTIVE_LEVEL, ACTIVE_HIGH}: begin
      end
      {ACTIVE_EDGE, ACTIVE_LOW}: begin
      end
      {ACTIVE_EDGE, ACTIVE_HIGH}: begin
      end
    endcase
    
    set_intenset(set_bits, id);
    // reg_inten and GPIOINT have one fclk cycle, wait_cycle to make sure data is stable
    wait_cycles(3, CLK_FCLK);
    // check interrupt via interface
    check_int_via_intf(id, 1);
    // check interrupt status via reg
    check_int_via_reg(id, 1);
    
    //clear interrupt
    set_intenclr(set_bits);
    set_intclear(set_bits);
    wait_cycles(3, CLK_FCLK);
    //check interrupt
    check_int_via_intf(id, 0);
    check_int_via_reg(id, 0);

    set_inttypeclr(set_bits);
    set_intpolclr(set_bits);
  endtask

  task check_int_via_intf(int id, bit val);
    compare_data(vif.gpioint[id], val);
  endtask

  task check_int_via_reg(int id, bit val);
    uvm_status_e status;
    bit [15:0] gpioint;
    rgm.INTSTATUS.read(status, gpioint);
    compare_data(gpioint[id], val);
  endtask

endclass


`endif
