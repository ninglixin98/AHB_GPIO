`ifndef RKV_GPIO_COV_SV
`define RKV_GPIO_COV_SV

class rkv_gpio_cov extends rkv_gpio_subscriber;

  `uvm_component_utils(rkv_gpio_cov)


  function new (string name = "rkv_gpio_cov", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(lvc_ahb_transaction tr);
  endfunction

  task do_listen_events();
    
  endtask

endclass

`endif 
