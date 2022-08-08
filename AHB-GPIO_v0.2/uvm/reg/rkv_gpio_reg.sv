`ifndef RKV_GPIO_REG_SV
`define RKV_GPIO_REG_SV

class rkv_gpio_rgm extends uvm_reg_block;

  `uvm_object_utils(rkv_gpio_rgm)

  uvm_reg_map map;
  function new(string name = "rkv_watchdog_rgm");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function build();
    map = create_map("map", 'h0, 4, UVM_LITTLE_ENDIAN);
    // TODO
    lock_model();
  endfunction


endclass


`endif
