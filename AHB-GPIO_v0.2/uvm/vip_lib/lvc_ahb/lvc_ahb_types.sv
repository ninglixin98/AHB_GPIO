`ifndef LVC_AHB_TYPES_SV
`define LVC_AHB_TYPES_SV

  typedef enum bit[1:0] {
      OKAY   = 2'b00, /**< OKAY response */ 
      ERROR  = 2'b01, /**< ERROR response */
      RETRY  = 2'b10, /**< RETRY response */
      SPLIT  = 2'b11  /**< SPLIT response */
  } response_type_enum;

  typedef enum bit[1:0] {
    IDLE =   2'b00, /**< IDLE transaction */
    BUSY =   2'b01, /**< BUSY transaction */
    NSEQ =   2'b10, /**< NONSEQUENTIAL transaction */
    SEQ  =   2'b11  /**< SEQUENTIAL transaction */ 
  } trans_type_enum;

  typedef enum bit[2:0] {
    BURST_SIZE_8BIT    = 3'b000, /**< 8-bits transfer size */   
    BURST_SIZE_16BIT   = 3'b001, /**< 16-bits transfer size */   
    BURST_SIZE_32BIT   = 3'b010, /**< 32-bits transfer size */  
    BURST_SIZE_64BIT   = 3'b011, /**< 64-bits transfer size */   
    BURST_SIZE_128BIT  = 3'b100, /**< 128-bits transfer size */ 
    BURST_SIZE_256BIT  = 3'b101, /**< 256-bits transfer size */ 
    BURST_SIZE_512BIT  = 3'b110, /**< 512-bits transfer size */ 
    BURST_SIZE_1024BIT = 3'b111  /**< 1024-bits transfer size */ 
  } burst_size_enum;

  typedef enum bit[2:0] {
    SINGLE =  3'b000, /**< SINGLE Burst type */                
    INCR   =  3'b001, /**< INCR Burst type */                  
    WRAP4  =  3'b010, /**< 4-beat WRAP Burst type */                
    INCR4  =  3'b011, /**< 4-beat INCR Burst type */                
    WRAP8  =  3'b100, /**< 8-beat WRAP Burst type */                
    INCR8  =  3'b101, /**< 8-beat INCR Burst type */                
    WRAP16 =  3'b110, /**< 16-beat WRAP Burst type */               
    INCR16 =  3'b111  /**< 16-beat INCR Burst type */               
  } burst_type_enum;

  typedef enum bit[1:0] {
    READ       = 2'b00, /**< Read transaction. */               
    WRITE      = 2'b01, /**< Write transaction. */             
    IDLE_XACT  = 2'b10 /**< Idle transaction. In case of active Master: 
                                                      all the control signals except hlock(always zero) can be controlled 
                                                      through respective transaction attributes 
                                                      (similar to READ or WRITE transaction types); 
                                                      the value of hwrite signal can be controlled through 
                                                      lvc_ahb_transaction::idle_xact_hwrite. */
  } xact_type_enum;

  typedef enum bit[1:0] {
   INITIAL        ='b00, //  Indicates the default state of the flag. It gets 
                         //  updated once the beat level transfer begins
   PARTIAL_ACCEPT ='b01, //  The status changes from INITIAL to PARTIAL_ACCEPT 
                         //  once the address of each beat is accepted by slave
   ACCEPT         ='b10, //  The status changes to ACCEPT once the beat level
                         //  data is accepted by the slave
   ABORTED        ='b11  //  The status changes to ABORT in case the transaction
                         //  is ABORTED due to ERROR/SPLIT or RETRY response from
                         //  the slave or in case of EBT
  } status_enum;

  function bit [31:0] extract_valid_data([`LVC_AHB_MAX_DATA_WIDTH - 1:0] data
                                        ,[`LVC_AHB_MAX_ADDR_WIDTH - 1 : 0] addr
                                        ,burst_size_enum bsize);
  
    case(bsize)
      BURST_SIZE_8BIT   : return (data >> (8*addr[1:0])) & 8'hFF;
      BURST_SIZE_16BIT  : return (data >> (16*addr[1]) ) & 16'hFFFF;
      BURST_SIZE_32BIT  : return data & 32'hFFFF_FFFF;
      BURST_SIZE_64BIT  : begin `uvm_error("TYPEERR", "burst size not supported") end
      default : begin `uvm_error("TYPEERR", "burst size not supported") end
    endcase
  endfunction


`endif 
