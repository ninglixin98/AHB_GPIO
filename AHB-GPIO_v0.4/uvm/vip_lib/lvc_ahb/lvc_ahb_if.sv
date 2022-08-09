`ifndef LVC_AHB_IF_SV
`define LVC_AHB_IF_SV

interface lvc_ahb_if;
  `include "lvc_ahb_defines.svh"
  import lvc_ahb_pkg::*;

  logic                                   hclk;
  logic                                   hresetn;

  logic                                   hgrant;
  logic [(`LVC_AHB_MAX_DATA_WIDTH - 1):0] hrdata;
  logic                                   hready;
  logic [1:0]                             hresp;
  logic [(`LVC_AHB_MAX_ADDR_WIDTH - 1):0] haddr;
  logic [2:0]                             hburst;
  logic                                   hbusreq;
  logic                                   hlock;
  logic [3:0]                             hprot;
  logic [2:0]                             hsize;
  logic [1:0]                             htrans;
  logic [(`LVC_AHB_MAX_DATA_WIDTH - 1):0] hwdata;
  logic                                   hwrite;

  response_type_enum                      debug_hresp;
  trans_type_enum                         debug_htrans;
  burst_size_enum                         debug_hsize;
  burst_type_enum                         debug_hburst;
  xact_type_enum                          debug_xact;
  status_enum                             debug_status;

  // debug signals assignment
  assign debug_hresp    = response_type_enum'(hresp);
  assign debug_htrans   = trans_type_enum'(htrans);
  assign debug_hsize    = burst_size_enum'(hsize);
  assign debug_hburst   = burst_type_enum'(hburst);
  // the below signals to be assigned by monitor
  // debug_xact ..
  // debug_status ..

  clocking cb_mst @(posedge hclk);
    // USER: Add clocking block detail
    default input #1ps output #1ps;
    output haddr, hburst, hbusreq, hlock, hprot, hsize, htrans, hwdata, hwrite; 
    input hready, hgrant, hrdata, hresp;
  endclocking : cb_mst

  clocking cb_slv @(posedge hclk);
   // USER: Add clocking block detail
    default input #1ps output #1ps;
    input haddr, hburst, hbusreq, hlock, hprot, hsize, htrans, hwdata, hwrite; 
    output hready, hgrant, hrdata, hresp;
  endclocking : cb_slv

  clocking cb_mon @(posedge hclk);
   // USER: Add clocking block detail
    default input #1ps output #1ps;
    input haddr, hburst, hbusreq, hlock, hprot, hsize, htrans, hwdata, hwrite; 
    input hready, hgrant, hrdata, hresp;
  endclocking : cb_mon

endinterface


`endif // LVC_AHB_IF_SV
