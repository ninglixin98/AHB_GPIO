
`ifndef LVC_AHB_MASTER_MONITOR_SV
`define LVC_AHB_MASTER_MONITOR_SV

class lvc_ahb_master_monitor extends lvc_ahb_monitor;

  `uvm_component_utils(lvc_ahb_master_monitor)

  function new(string name = "lvc_ahb_master_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

endclass


`endif // LVC_AHB_MASTER_MONITOR_SV
