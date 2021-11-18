`timescale 1ns/1ps

module BCD_gen(

input [16:0] trig,
input clk,
output reg [7:0] sign,
output reg [7:0] int_comp,
output [7:0] tenths,
output [7:0] hundredths,
output [7:0] thousandths,
output [7:0] ten_thousandths,
output [7:0] hundred_thousandths,
output [7:0] millionths         

);

always@(posedge clk) begin
  case(trig[16])
  
    0: sign = 8'hff;
	default: sign = 8'hbf;
  
  endcase
  
  case(trig[15])
  
    0: int_comp = 8'h40;
	default: int_comp = 8'h79;
  
  endcase  
  
end  


ROM_lookup_table ROM(
    .clk                (clk),
    .addr               (trig[14:9]),
    .tenths             (tenths), 
	.hundredths         (hundredths),
    .thousandths        (thousandths),
    .ten_thousandths    (ten_thousandths),
    .hundred_thousandths(hundred_thousandths),
    .millionths         (millionths         )

    );

endmodule