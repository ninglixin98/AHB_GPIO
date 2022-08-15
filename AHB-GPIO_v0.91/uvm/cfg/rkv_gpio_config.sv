`ifndef RKV_GPIO_CONFIG_SV
`define RKV_GPIO_CONFIG_SV

class rkv_gpio_config extends uvm_object;

  int seq_check_count;
  int seq_check_error;

  int scb_check_count;
  int scb_check_error;

  bit enable_cov = 1;
  bit enable_scb = 1;

  lvc_ahb_agent_configuration ahb_cfg;
  virtual rkv_gpio_if vif;
  rkv_gpio_rgm rgm;

  `uvm_object_utils(rkv_gpio_config)

  // USER to specify the config items
  
  function new (string name = "rkv_gpio_config");
    super.new(name);
    ahb_cfg = lvc_ahb_agent_configuration::type_id::create("ahb_cfg");
  endfunction : new

endclass

`endif // RKV_GPIO_CONFIG_SV
