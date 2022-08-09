`ifndef LVC_AHB_DRIVER_SV
`define LVC_AHB_DRIVER_SV

class lvc_ahb_driver #(type REQ = lvc_ahb_transaction, type RSP = REQ) extends uvm_driver #(REQ, RSP);
  lvc_ahb_agent_configuration cfg;
  virtual lvc_ahb_if vif;
  `uvm_component_utils(lvc_ahb_driver)

  function new(string name = "lvc_ahb_driver", uvm_component parent = null);
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
    fork
     get_and_drive();
     reset_listener();
    join_none
  endtask

  virtual task get_and_drive();
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), "sequencer got next item", UVM_HIGH)
      drive_transfer(req);
      void'($cast(rsp, req.clone()));
      rsp.set_sequence_id(req.get_sequence_id());
      rsp.set_transaction_id(req.get_transaction_id());
      seq_item_port.item_done(rsp);
      `uvm_info(get_type_name(), "sequencer item_done_triggered", UVM_HIGH)
    end
  endtask : get_and_drive

  virtual task drive_transfer(REQ t);
    // TODO implementation in child class
  endtask

  virtual task reset_listener();
    // TODO implementation in child class
  endtask

endclass


`endif // LVC_AHB_DRIVER_SV
