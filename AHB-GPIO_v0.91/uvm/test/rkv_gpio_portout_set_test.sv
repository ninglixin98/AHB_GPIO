`ifndef RKV_GPIO_PORTOUT_SET_TEST_SV
`define RKV_GPIO_PORTOUT_SET_TEST_SV

class rkv_gpio_portout_set_test extends rkv_gpio_base_test;

  `uvm_component_utils(rkv_gpio_portout_set_test)

  function new (string name = "rkv_gpio_portout_set_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    rkv_gpio_portout_set_virt_seq seq = rkv_gpio_portout_set_virt_seq::type_id::create("this");
    super.run_phase(phase);
    phase.raise_objection(this);
    seq.start(env.virt_sqr);
    phase.drop_objection(this);
  endtask

endclass

`endif
