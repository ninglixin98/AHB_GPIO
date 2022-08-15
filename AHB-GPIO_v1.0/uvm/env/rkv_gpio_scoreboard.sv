`ifndef RKV_GPIO_SCOREBOARD_SV
`define RKV_GPIO_SCOREBOARD_SV

class rkv_gpio_scoreboard extends rkv_gpio_subscriber;

  `uvm_component_utils(rkv_gpio_scoreboard)

  function new (string name = "rkv_gpio_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

  function void write(lvc_ahb_transaction tr);
  endfunction

  task do_listen_events();
  endtask

endclass

`endif 
