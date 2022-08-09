`ifndef LVC_AHB_MASTER_TRANSACTION_SV
`define LVC_AHB_MASTER_TRANSACTION_SV

class lvc_ahb_master_transaction extends lvc_ahb_transaction;
  `uvm_object_utils_begin(lvc_ahb_master_transaction)
  `uvm_object_utils_end

  function new(string name = "lvc_ahb_master_transaction");
    super.new(name);
  endfunction


endclass


`endif // LVC_AHB_MASTER_TRANSACTION_SV
