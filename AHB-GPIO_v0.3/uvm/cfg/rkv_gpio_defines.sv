`ifndef RKV_GPIO_DEFINES_SV
`define RKV_GPIO_DEFINES_SV

parameter bit [15:0] RKV_ROUTER_REG_ADDR_DATA         = 16'h0000; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_DATAOUT      = 16'h0004; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_OUTENSET     = 16'h0010; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_OUTENCLR     = 16'h0014; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTENSET     = 16'h0020; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTENCLR     = 16'h0024; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTTYPESET   = 16'h0028; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTTYPECLR   = 16'h002C; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTPOLSET    = 16'h0030; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTPOLCLR    = 16'h0034; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTSTATUS    = 16'h0038; 
parameter bit [15:0] RKV_ROUTER_REG_ADDR_INTCLEAR     = 16'h0038; 


`endif//RKV_GPIO_DEFINES_SV

