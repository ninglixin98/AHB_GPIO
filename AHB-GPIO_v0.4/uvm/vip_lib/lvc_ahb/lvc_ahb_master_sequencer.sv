`ifndef LVC_AHB_MASTER_SEQUENCER_SV
`define LVC_AHB_MASTER_SEQUENCER_SV

class lvc_ahb_master_sequencer extends lvc_ahb_sequencer;
  lvc_ahb_agent_configuration cfg;
  virtual lvc_ahb_if vif;

  `uvm_component_utils(lvc_ahb_master_sequencer)

  function new(string name = "lvc_ahb_master_sequencer", uvm_component parent = null);
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


`endif // LVC_AHB_MASTER_SEQUENCER_SV
