`timescale 1ns/1ps

module T_gen(
input clk,
output [7:0] T
);

reg [19:0] t_count = 0;
wire trigger = &t_count[17:0];
reg [7:0] t_tmp;
assign T = t_tmp;
initial begin
  t_tmp = 8'b11111110;
end

always@(posedge clk) begin
  t_count <= t_count + 1;
  
  if(trigger) 
    t_tmp <= {t_tmp[0],t_tmp[7:1]};
  
end


endmodule