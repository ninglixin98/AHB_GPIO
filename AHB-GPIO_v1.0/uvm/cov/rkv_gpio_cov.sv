`ifndef RKV_GPIO_COV_SV
`define RKV_GPIO_COV_SV

class rkv_gpio_cov extends rkv_gpio_subscriber;

  `uvm_component_utils(rkv_gpio_cov)

  rkv_gpio_t1_data_cg cg_reg_data_write;
  rkv_gpio_t1_data_cg cg_reg_data_read;
  rkv_gpio_t1_data_cg cg_reg_dataout_write;
  rkv_gpio_t1_data_cg cg_reg_dataout_read;

  rkv_gpio_t2_ctrl_wr_cg cg_reg_intenset_write;
  rkv_gpio_t2_ctrl_rd_cg cg_reg_intenset_read;
  rkv_gpio_t2_ctrl_wr_cg cg_reg_intenclr_write;
  rkv_gpio_t2_ctrl_rd_cg cg_reg_intenclr_read;

  function new (string name = "rkv_gpio_cov", uvm_component parent);
    super.new(name, parent);
    cg_reg_data_write = new();
    cg_reg_data_write.option.name = "cg_reg_data_write";
    cg_reg_data_read = new();
    cg_reg_data_read.option.name = "cg_reg_data_read";
    cg_reg_dataout_write = new();
    cg_reg_dataout_write.option.name = "cg_reg_dataout_write";
    cg_reg_dataout_read = new();
    cg_reg_dataout_read.option.name = "cg_reg_dataout_read";
    cg_reg_intenset_write = new();
    cg_reg_intenset_write.option.name = "cg_reg_intenset_write";
    cg_reg_intenset_read = new();
    cg_reg_intenset_read.option.name = "cg_reg_intenset_read";
    cg_reg_intenclr_write = new();
    cg_reg_intenclr_write.option.name = "cg_reg_intenclr_write";
    cg_reg_intenclr_read = new();
    cg_reg_intenclr_read.option.name = "cg_reg_intenclr_read";
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(lvc_ahb_transaction tr);
    super.write(tr); 
    if(tr.xact_type == lvc_ahb_pkg::WRITE) begin
      case(current_reg.get_name())
        "DATA": cg_reg_data_write.sample(tr.data[0]);
        "DATAOUT": cg_reg_dataout_write.sample(tr.data[0]);
        "INTENSET": cg_reg_intenset_write.sample(tr.data[0]);
        "INTENCLR": cg_reg_intenclr_write.sample(tr.data[0]);
      endcase
    end
    else if(tr.xact_type == lvc_ahb_pkg::READ) begin
      case(current_reg.get_name())
        "DATA": cg_reg_data_read.sample(tr.data[0]);
        "DATAOUT": cg_reg_dataout_read.sample(tr.data[0]);
        "INTENSET": cg_reg_intenset_read.sample(tr.data[0]);
        "INTENCLR": cg_reg_intenclr_read.sample(tr.data[0]);
      endcase
    end
  endfunction


  task do_listen_events();
    uvm_object tmp;
    uvm_reg r;
    super.do_listen_events();
    fork
      forever begin
        wait(cfg.enable_cov);
        gpio_regacc_fd_e.wait_trigger_data(tmp);
        void'($cast(r, tmp));
        #1ps; // wait fime for reg model updated
        case(r.get_name())
          //"DATA":

        endcase
      end
    join_none
  endtask

endclass

`endif 
