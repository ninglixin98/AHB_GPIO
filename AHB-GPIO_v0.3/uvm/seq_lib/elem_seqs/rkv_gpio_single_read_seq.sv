`ifndef RKV_GPIO_SINGLE_READ_SEQ_SV
`define RKV_GPIO_SINGLE_READ_SEQ_SV

class rkv_gpio_single_read_seq extends rkv_gpio_base_element_sequence;
  rand bit [31:0]      addr;
  rand bit [31:0]      data;
  rand burst_size_enum bsize;
  constraint single_read_cstr {
    soft addr[1:0] == 0;
    soft bsize == BURST_SIZE_32BIT;
  }
  `uvm_object_utils(rkv_gpio_single_read_seq)
  function new (string name = "rkv_gpio_single_read_seq");
    super.new(name);
  endfunction
  virtual task body();
    lvc_ahb_master_single_trans ahb_single;
    `uvm_info("body", "Entered...", UVM_LOW)
    `uvm_do_on_with(ahb_single, p_sequencer.ahb_mst_sqr, 
                    {addr == local::addr; xact == READ; bsize == local::bsize;}
                   )
    data = ahb_single.data;
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass

`endif // RKV_GPIO_SINGLE_READ_SEQ_SV
