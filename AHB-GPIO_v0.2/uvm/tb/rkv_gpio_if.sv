`ifndef RKV_GPIO_IF_SV
`define RKV_GPIO_IF_SV

interface rkv_gpio_if;
  logic clk; // AHB bus hclk
  logic fclk;
  logic rstn;
  logic [15:0] portin;
  logic [15:0] portout;
  logic [15:0] porten;
  logic [15:0] portfunc;
  logic [15:0] gpioint;
  logic        combint;

  initial begin : rstn_gen
    assert_reset(10);
  end

  task automatic assert_reset(int nclks = 1, int delay = 0);
    #(delay * 1ns);
    repeat(nclks) @(posedge clk);
    rstn <= 0;
    repeat(5) @(posedge clk);
    rstn <= 1;
  endtask

endinterface


`endif // RKV_GPIO_IF_SV

