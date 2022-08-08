`ifndef RKV_GPIO_PORTOUT_SET_VIRT_SEQ_SV
`define RKV_GPIO_PORTOUT_SET_VIRT_SEQ_SV


class rkv_gpio_portout_set_virt_seq extends rkv_gpio_base_virtual_sequence;
  `uvm_object_utils(rkv_gpio_portout_set_virt_seq)

  function new (string name = "rkv_gpio_portout_set_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)


    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass


`endif 
