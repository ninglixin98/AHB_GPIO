`ifndef LVC_AHB_MASTER_SINGLE_TRANS_SV
`define LVC_AHB_MASTER_SINGLE_TRANS_SV

class lvc_ahb_master_single_trans extends lvc_ahb_base_sequence;
  rand bit [`LVC_AHB_MAX_ADDR_WIDTH-1:0]      addr;
  rand bit [`LVC_AHB_MAX_DATA_WIDTH-1:0]      data;
  rand xact_type_enum  xact;
  rand burst_size_enum bsize;

  constraint single_trans_cstr {
    xact inside {READ, WRITE};
  }

  `uvm_object_utils(lvc_ahb_master_single_trans)    

  function new(string name=""); 
    super.new(name);
  endfunction : new

  virtual task body();
    `uvm_info(get_type_name(),"Starting sequence", UVM_HIGH)
	  `uvm_do_with(req, {
                       addr == local::addr;
                       data.size() == 1;
                       data[0] == local::data;
                       burst_size == bsize;
                       burst_type == SINGLE;
                       xact_type == xact;
                      })
    get_response(rsp);
    if(xact == READ) 
      data = rsp.data[0];
    `uvm_info(get_type_name(),$psprintf("Done sequence: %s",req.convert2string()), UVM_HIGH)
  endtask: body

endclass : lvc_ahb_master_single_trans 


`endif

