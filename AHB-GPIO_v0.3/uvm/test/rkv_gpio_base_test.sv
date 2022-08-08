`ifndef RKV_GPIO_BASE_TEST_SV
`define RKV_GPIO_BASE_TEST_SV

virtual class rkv_gpio_base_test extends uvm_test;

  rkv_gpio_config cfg;
  rkv_gpio_env env;
  rkv_gpio_rgm rgm;

  function new (string name = "rkv_gpio_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rgm = rkv_gpio_rgm::type_id::create("rgm");
    rgm.build();
    uvm_config_db#(rkv_gpio_rgm)::set(this, "env", "rgm", rgm);
    cfg = rkv_gpio_config::type_id::create("cfg");
    cfg.rgm = rgm;
    if(!uvm_config_db#(virtual rkv_gpio_if)::get(this,"","vif", cfg.vif))
      `uvm_fatal("GETCFG","cannot get virtual interface from config DB")
    uvm_config_db#(rkv_gpio_config)::set(this, "env", "cfg", cfg);
    env = rkv_gpio_env::type_id::create("env", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.phase_done.set_drain_time(this, 1us);
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask


endclass

`endif
