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
    set_intenset(set_bits, id);
    // check interrupt via interface
    // check interrupt status via reg
    #100ns;
    set_intclear(set_bits);
    set_inttypeclr(set_bits);
    set_intpolclr(set_bits);
  endtask

endclass


`endif
