`ifndef RKV_GPIO_BASE_VIRTUAL_SEQUENCE_SV
`define RKV_GPIO_BASE_VIRTUAL_SEQUENCE_SV

class rkv_gpio_base_virtual_sequence extends uvm_sequence;

  rkv_gpio_config cfg;
  virtual rkv_gpio_if vif;
  rkv_gpio_rgm rgm;
  bit[31:0] wr_val, rd_val;
  uvm_status_e status;

  // element sequence declartion
  rkv_gpio_single_write_seq single_write;
  rkv_gpio_single_read_seq single_read;

  `uvm_object_utils(rkv_gpio_base_virtual_sequence)
  `uvm_declare_p_sequencer(rkv_gpio_virtual_sequencer)

  function new (string name = "rkv_gpio_base_virtual_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entered...", UVM_LOW)
    // get cfg from p_sequencer
    cfg = p_sequencer.cfg;
    vif = cfg.vif;
    rgm = cfg.rgm;
    // TODO in sub-class
    wait_ready_for_stim();
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

  virtual function void compare_data(logic[31:0] val1, logic[31:0] val2, bit wildcmp = 0);
    cfg.seq_check_count++;
    if(wildcmp == 0) begin
      if(val1 === val2)
        `uvm_info("CMPSUC", $sformatf("val1 'h%0x === val2 'h%0x", val1, val2), UVM_LOW)
      else begin
       cfg.seq_check_error++;
       `uvm_error("CMPERR", $sformatf("val1 'h%0x !== val2 'h%0x", val1, val2))
      end
    end
    else begin // x considered as wildcard
      foreach(val1[i]) begin
        if(val1[i] !== 1'bx && val2[i] !== 1'bx) begin
          if(val1[i] !== val2[i]) begin
            cfg.seq_check_error++;
            `uvm_error("CMPERR", $sformatf("val1 'b%0b !== val2 'b%0b", val1, val2))
            return;
          end
        end
      end
      `uvm_info("CMPSUC", $sformatf("val1 'b%0b === val2 'b%0b", val1, val2), UVM_LOW)
    end
  endfunction


  task wait_reset_signal_assertted();
      @(posedge vif.rstn);
  endtask

  task wait_reset_signal_released();
      @(negedge vif.rstn);
  endtask

  task wait_cycles(int n = 1, RKV_CLK_T t = CLK_HCLK);
    if(CLK_HCLK)
      repeat(n) @(posedge vif.clk);
    else
      repeat(n) @(posedge vif.fclk);
  endtask

  task wait_ready_for_stim();
    wait_reset_signal_released();
    drive_portin_idle();
    wait_cycles(10);
  endtask

  task drive_portin_idle();
    vif.drive_portin(0);
  endtask

  //GPIO REG ACCESS API
  //bits[i] = 1'bx  ->  masked bit
  task set_portout_bits(logic [15:0] bits);
    logic [15:0] pout;
    uvm_status_e status;
    //first read pout to record the present value , then operate basis on pout, finally write new pout to reg    
    //read_reg_with_addr(RKV_ROUTER_REG_ADDR_DATAOUT, pout);
    rgm.DATAOUT.read(status, pout);
    foreach(bits[i]) begin
      pout[i] = bits[i] === 1'bx ? pout[i] : bits[i];
    end
    //write_reg_with_addr(RKV_ROUTER_REG_ADDR_DATAOUT, pout);
    rgm.DATAOUT.write(status, pout);
  endtask

  //id > 0 -> masked bit
  task get_portin(output bit [15:0] bits, int id = -1);
    bit bit_id = 0; 
    //read_reg_with_addr(RKV_ROUTER_REG_ADDR_DATA, bits);
    rgm.DATA.read(status, bits);
    if(id >0) begin
      bit_id = bits[id];
      bits = 0;
      bits[id] = bit_id;
    end
  endtask

  // id > 0 -> masked bit
  task set_intenset(input bit [15:0] bits, int id = -1);
    uvm_status_e status;
    bit[15:0] intenset;
    if(id < 0) begin
      rgm.INTENSET.write(status, bits);
    end
    else begin // single bit set
      intenset = rgm.INTENSET.get();
      intenset[id] = bits[id];
      rgm.INTENSET.set(intenset);
      rgm.INTENSET.update(status);
    end
  endtask

  task set_intenclr(input bit [15:0] bits);
    uvm_status_e status;
    rgm.INTENCLR.write(status, bits);
  endtask

  task set_inttypeset(input bit [15:0] bits, int id = -1);
    uvm_status_e status;
    bit[15:0] inttypeset;
    if(id < 0) begin
      rgm.INTTYPESET.write(status, bits);
    end
    else begin // single bit set
      inttypeset = rgm.INTTYPESET.get();
      inttypeset[id] = bits[id];
      rgm.INTTYPESET.set(inttypeset);
      rgm.INTTYPESET.update(status);
    end
  endtask

  task set_intpolset(input bit [15:0] bits, int id = -1);
    uvm_status_e status;
    bit[15:0] intpolset;
    if(id < 0) begin
      rgm.INTPOLSET.write(status, bits);
    end
    else begin // single bit set
      intpolset = rgm.INTPOLSET.get();
      intpolset[id] = bits[id];
      rgm.INTPOLSET.set(intpolset);
      rgm.INTPOLSET.update(status);
    end
  endtask

  task set_inttypeclr(input bit [15:0] bits);
    uvm_status_e status;
    rgm.INTTYPECLR.write(status, bits);
  endtask

  task set_intpolclr(input bit [15:0] bits);
    uvm_status_e status;
    rgm.INTPOLCLR.write(status, bits);
  endtask

  task set_intclear(input bit [15:0] bits);
    uvm_status_e status;
    rgm.INTCLEAR.write(status, bits);
  endtask

  task read_reg_with_addr(bit [31:0] addr, output bit [31:0] data);
    `uvm_do_with(single_read, {addr == local::addr;})
    data = single_read.data;
  endtask

  task write_reg_with_addr(bit [31:0] addr, bit [31:0] data);
    `uvm_do_with(single_write, {addr == local::addr; data == local::data;})
  endtask


endclass

`endif  
