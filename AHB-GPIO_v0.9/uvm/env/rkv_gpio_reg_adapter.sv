`ifndef RKV_GPIO_REG_ADAPTER_SV 
`define RKV_GPIO_REG_ADAPTER_SV 

class rkv_gpio_reg_adapter extends uvm_reg_adapter;
  `uvm_object_utils(rkv_gpio_reg_adapter)
  
  function new(string name = "rkv_gpio_reg_adapter");
    super.new(name);
    provides_responses = 1;
  endfunction
  
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    lvc_ahb_transaction t = lvc_ahb_transaction::type_id::create("t");
    t.xact_type = (rw.kind == UVM_WRITE) ? WRITE : READ;
    t.addr = rw.addr;
    t.burst_size = BURST_SIZE_32BIT;
    t.burst_type = SINGLE;
    t.data = new[1];
    t.data[0] = rw.data;
    return t;
  endfunction
  
  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    lvc_ahb_transaction t;
    if (!$cast(t, bus_item)) begin
      `uvm_fatal("CASTFAIL","Provided bus_item is not of the correct type")
      return;
    end
    rw.kind = (t.xact_type == WRITE) ? UVM_WRITE : UVM_READ;
    rw.addr = t.addr;
    rw.data = t.data[0];
    rw.status = UVM_IS_OK;
  endfunction
endclass

`endif // RKV_GPIO_REG_ADAPTER_SV 
