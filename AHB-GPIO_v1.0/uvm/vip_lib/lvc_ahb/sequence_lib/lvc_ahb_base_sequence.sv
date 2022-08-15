`ifndef LVC_AHB_BASE_SEQUENCE_SV
`define LVC_AHB_BASE_SEQUENCE_SV

class lvc_ahb_base_sequence extends uvm_sequence #(lvc_ahb_transaction);

  `uvm_object_utils(lvc_ahb_base_sequence)    
  function new(string name=""); 
    super.new(name);
  endfunction : new

endclass : lvc_ahb_base_sequence 


`endif

