module rkv_gpio_tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_gpio_pkg::*;

  logic clk;
  logic rstn;

  initial begin : clk_gen
    clk = 0;
    forever #2ns clk = !clk;
  end

  cmsdk_ahb_gpio dut (
   .HCLK(ahb_if.hclk  ),      // system bus clock                                   
   .HRESETn(ahb_if.hresetn  ),   // system bus reset                                    
   .FCLK(ahb_if.hclk  ),      // system bus clock                                   
   .HSEL(1'b1  ),      // AHB peripheral select                              
   .HREADY(ahb_if.hready  ),    // AHB ready input                                    
   .HTRANS(ahb_if.htrans  ),    // AHB transfer type                            
   .HSIZE(ahb_if.hsize  ),     // AHB hsize                                    
   .HWRITE(ahb_if.hwrite  ),    // AHB hwrite                                         
   .HADDR(ahb_if.haddr[11:0]  ),     // AHB address bus                             
   .HWDATA(ahb_if.hwdata  ),    // AHB write data bus                          
   .ECOREVNUM(4'b0110  ),  // Engineering-change-order revision bits       
   .PORTIN(gpio_if.portin  ),     // GPIO Interface input                        
   .HREADYOUT(ahb_if.hready  ), // AHB ready output to S->M mux                       
   .HRESP(ahb_if.hresp  ),     // AHB response                                 
   .HRDATA(ahb_if.hrdata  ),                                                 
   .PORTOUT(gpio_if.portout  ),    // GPIO output                              
   .PORTEN(gpio_if.porten  ),     // GPIO output enable                        
   .PORTFUNC(gpio_if.portfunc  ),   // Alternate function control              
   .GPIOINT(gpio_if.gpioint  ),    // Interrupt output for each pin            
   .COMBINT(gpio_if.combint  )     // Combined interrupt                       
  );



  lvc_ahb_if ahb_if();
  assign ahb_if.hclk    = clk;
  assign ahb_if.hresetn = rstn;
  assign ahb_if.hgrant  = 1'b1;

  rkv_gpio_if gpio_if();
  assign gpio_if.clk  = clk;
  assign gpio_if.fclk = clk;
  assign rstn         = gpio_if.rstn;

  initial begin
    uvm_config_db#(virtual lvc_ahb_if)::set(uvm_root::get(), "uvm_test_top.env.ahb_mst", "vif", ahb_if);
    uvm_config_db#(virtual rkv_gpio_if)::set(uvm_root::get(), "uvm_test_top", "vif", gpio_if);
    uvm_config_db#(virtual rkv_gpio_if)::set(uvm_root::get(), "uvm_test_top.env", "vif", gpio_if);
    uvm_config_db#(virtual rkv_gpio_if)::set(uvm_root::get(), "uvm_test_top.env.virt_sqr", "vif", gpio_if);
    run_test();
  end


endmodule
