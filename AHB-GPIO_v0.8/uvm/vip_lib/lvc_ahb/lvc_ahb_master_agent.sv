`ifndef LVC_AHB_MASTER_AGENT_SV
`define LVC_AHB_MASTER_AGENT_SV

class lvc_ahb_master_agent extends uvm_agent;
  
  lvc_ahb_agent_configuration cfg;

  lvc_ahb_master_driver driver;
  
  lvc_ahb_master_monitor monitor;

  lvc_ahb_master_sequencer sequencer;

  virtual lvc_ahb_if vif;

  `uvm_component_utils(lvc_ahb_master_agent)

  function new(string name = "lvc_ahb_master_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(lvc_ahb_agent_configuration)::get(this,"","cfg", cfg)) begin
      `uvm_fatal("GETCFG","cannot get config object from config DB")
    end
    if(!uvm_config_db#(virtual lvc_ahb_if)::get(this,"","vif", vif)) begin
      `uvm_fatal("GETVIF","cannot get vif handle from config DB")
    end

    monitor = lvc_ahb_master_monitor::type_id::create("monitor", this);

    if(cfg.is_active) begin
      driver = lvc_ahb_master_driver::type_id::create("driver", this);
      sequencer = lvc_ahb_master_sequencer::type_id::create("sequencer", this);
    end

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    monitor.vif = vif;
    if(cfg.is_active) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
      driver.vif = vif;
      sequencer.vif = vif;
    end
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

endclass


`endif // LVC_AHB_MASTER_AGENT_SV
