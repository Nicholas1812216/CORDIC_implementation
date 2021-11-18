`timescale 1ns/1ps

module top_module(
  input clk,
  input [15:0] theta,
  input cos_sin,
  
  output [7:0] T,
  output A,B,C,D,E,F,G,DP
);

T_gen t_inst(
.clk(clk),
.T(T)
);


wire [16:0] sin, cos;

wire [7:0] sin_sign;             
wire [7:0] sin_int_comp;          
wire [7:0] sin_tenths;             
wire [7:0] sin_hundredths;         
wire [7:0] sin_thousandths;        
wire [7:0] sin_ten_thousandths;    
wire [7:0] sin_hundred_thousandths;
wire [7:0] sin_millionths;         

wire [7:0] cos_sign;             
wire [7:0] cos_int_comp;          
wire [7:0] cos_tenths;             
wire [7:0] cos_hundredths;         
wire [7:0] cos_thousandths;        
wire [7:0] cos_ten_thousandths;    
wire [7:0] cos_hundred_thousandths;
wire [7:0] cos_millionths; 

wire [7:0] sign;             
wire [7:0] int_comp;          
wire [7:0] tenths;             
wire [7:0] hundredths;         
wire [7:0] thousandths;        
wire [7:0] ten_thousandths;    
wire [7:0] hundred_thousandths;
wire [7:0] millionths; 
reg  [7:0] seg_out;

assign sign                = cos_sin ? cos_sign                : sin_sign;             
assign int_comp            = cos_sin ? cos_int_comp            : sin_int_comp;          
assign tenths              = cos_sin ? cos_tenths              : sin_tenths;            
assign hundredths          = cos_sin ? cos_hundredths          : sin_hundredths;        
assign thousandths         = cos_sin ? cos_thousandths         : sin_thousandths;       
assign ten_thousandths     = cos_sin ? cos_ten_thousandths     : sin_ten_thousandths;   
assign hundred_thousandths = cos_sin ? cos_hundred_thousandths : sin_hundred_thousandths;
assign millionths          = cos_sin ? cos_millionths          : sin_millionths;  

always@* begin
  case(T)
    8'b11111110: seg_out = millionths;
    8'b11111101: seg_out = hundred_thousandths;
    8'b11111011: seg_out = ten_thousandths;
    8'b11110111: seg_out = thousandths;
    8'b11101111: seg_out = hundredths;
    8'b11011111: seg_out = tenths;
    8'b10111111: seg_out = int_comp;
    8'b01111111: seg_out = sign;
	default: seg_out = 8'hfd;
	
  endcase
end    
  assign DP = seg_out[7];
  assign A = seg_out[0];
  assign B = seg_out[1];
  assign C = seg_out[2];
  assign D = seg_out[3];
  assign E = seg_out[4];
  assign F = seg_out[5];
  assign G = seg_out[6];

cordic #(9) cordic_inst //latency = number of iterations
             (
               .clk(clk),
			   .beta({1'b0,theta}),
			   .sin(sin),
			   .cos(cos)
			 );
			 
BCD_gen sin_gen(

.trig               (sin),
.clk                (clk),
.sign               (sin_sign               ),
.int_comp           (sin_int_comp           ),
.tenths             (sin_tenths             ),
.hundredths         (sin_hundredths         ),
.thousandths        (sin_thousandths        ),
.ten_thousandths    (sin_ten_thousandths    ),
.hundred_thousandths(sin_hundred_thousandths),
.millionths         (sin_millionths         )

);

BCD_gen cos_gen(

.trig               (cos),
.clk                (clk),
.sign               (cos_sign               ),
.int_comp           (cos_int_comp           ),
.tenths             (cos_tenths             ),
.hundredths         (cos_hundredths         ),
.thousandths        (cos_thousandths        ),
.ten_thousandths    (cos_ten_thousandths    ),
.hundred_thousandths(cos_hundred_thousandths),
.millionths         (cos_millionths         )

);		 		 


endmodule