`ifndef RKV_GPIO_PORTOUT_SET_VIRT_SEQ_SV
`define RKV_GPIO_PORTOUT_SET_VIRT_SEQ_SV


class rkv_gpio_portout_set_virt_seq extends rkv_gpio_base_virtual_sequence;
  `uvm_object_utils(rkv_gpio_portout_set_virt_seq)

  function new (string name = "rkv_gpio_portout_set_virt_seq");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] addr, data;
    bit [3:0] pin_num, pout_num;
    super.body();
    `uvm_info("body", "Entered...", UVM_LOW)
    repeat(10) begin
      std::randomize(pin_num, pout_num);
      set_and_check_portin(pin_num);
      set_and_check_portout(pout_num);
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

  task set_and_check_portin(bit[3:0] id);
    bit [15:0] pin_dr, pin_rd;
    bit bit_pattern [$] = {1, 0, 1};
    foreach(bit_pattern[i]) begin
     pin_dr[id] = bit_pattern[i];
     vif.drive_portin(pin_dr);
     // two-cycles for sync
     wait_cycles(3);
     get_portin(pin_rd, id);
     compare_data(pin_dr, pin_rd);
    end
  endtask

  task set_and_check_portout(bit[3:0] id);
    logic [15:0] pout_wr, pout_mo;
    bit bit_pattern [$] = {0, 1, 0};
    foreach(bit_pattern[i]) begin
      pout_wr[id] = bit_pattern[i];
      set_portout_bits(pout_wr);
      //one-cycle from io-bridge to portout
      wait_cycles(2);
      pout_mo = vif.portout;
      compare_data(pout_wr, pout_mo);
    end
  endtask

endclass


`endif 
