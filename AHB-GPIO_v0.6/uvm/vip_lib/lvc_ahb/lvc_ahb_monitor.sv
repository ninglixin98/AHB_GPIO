`ifndef LVC_AHB_MONITOR_SV
`define LVC_AHB_MONITOR_SV

class lvc_ahb_monitor extends uvm_monitor;
  lvc_ahb_agent_configuration cfg;
  virtual lvc_ahb_if vif;
  uvm_analysis_port #(lvc_ahb_transaction) item_observed_port;

  `uvm_component_utils(lvc_ahb_monitor)

  function new(string name = "lvc_ahb_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_observed_port = new("item_observed_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      monitor_transactions();
    join_none
  endtask

  task monitor_transactions();
    lvc_ahb_transaction t;
    forever begin
      collect_transfer(t);
      item_observed_port.write(t);
    end
  endtask

  task collect_transfer(output lvc_ahb_transaction t);
    // collect transfer from interface
    t = lvc_ahb_transaction::type_id::create("t");
    @(vif.cb_mon iff vif.cb_mon.htrans == NSEQ);
    t.trans_type = trans_type_enum'(vif.cb_mon.htrans);
    t.xact_type = xact_type_enum'(vif.cb_mon.hwrite);
    t.burst_type = burst_type_enum'(vif.cb_mon.hburst);
    t.burst_size = burst_size_enum'(vif.cb_mon.hsize);
    t.addr = vif.cb_mon.haddr;
    forever begin
      monitor_valid_data(t);
      if(t.trans_type == IDLE) 
        break;
    end
    t.response_type = t.all_beat_response[t.current_data_beat_num];
  endtask

  task monitor_valid_data(lvc_ahb_transaction t);
    @(vif.cb_mon iff vif.cb_mon.hready);
    t.increase_data();
    t.current_data_beat_num = t.data.size() - 1;
    // get draft data from bus 
    t.data[t.current_data_beat_num] = t.xact_type == WRITE ? vif.cb_mon.hwdata : vif.cb_mon.hrdata;
    // NOTE:: alinged not to extract the valid data after shifted
    // extract_vali_data(t.data[t.current_data_beat_num], t.addr, t.burst_size);
    t.all_beat_response[t.current_data_beat_num] = response_type_enum'(vif.cb_mon.hresp);
    t.trans_type = trans_type_enum'(vif.cb_mon.htrans);
  endtask

endclass


`endif // LVC_AHB_MONITOR_SV
