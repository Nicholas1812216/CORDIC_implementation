`timescale 1ns / 1ps

module ROM_lookup_table(
    input clk,
    input [5:0] addr,
    output [7:0] tenths,
	output [7:0] hundredths,
    output [7:0] thousandths,
    output [7:0] ten_thousandths,
    output [7:0] hundred_thousandths,
    output [7:0] millionths

    );

   localparam ROM_WIDTH = 8;
   localparam ROM_ADDR_BITS = 6;

   (* rom_style="{distributed | block}" *)
   reg [ROM_WIDTH-1:0] lookup_table_10 [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] lookup_table_100 [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] lookup_table_1000 [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] lookup_table_10000[(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] lookup_table_100000 [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] lookup_table_1000000 [(2**ROM_ADDR_BITS)-1:0];
   
   reg [ROM_WIDTH-1:0] output_data_10;
   reg [ROM_WIDTH-1:0] output_data_100;
   reg [ROM_WIDTH-1:0] output_data_1000;
   reg [ROM_WIDTH-1:0] output_data_10000;
   reg [ROM_WIDTH-1:0] output_data_100000;
   reg [ROM_WIDTH-1:0] output_data_1000000;

   wire [ROM_ADDR_BITS-1:0] address;

   initial begin
      $readmemh("C:/Users/19259/Documents/EGCP446/CORDIC_function/tenths.txt", lookup_table_10, 0, (2**ROM_ADDR_BITS)-1);
      $readmemh("C:/Users/19259/Documents/EGCP446/CORDIC_function/hundredths.txt", lookup_table_100, 0, (2**ROM_ADDR_BITS)-1);
      $readmemh("C:/Users/19259/Documents/EGCP446/CORDIC_function/thousandths.txt", lookup_table_1000, 0, (2**ROM_ADDR_BITS)-1);
      $readmemh("C:/Users/19259/Documents/EGCP446/CORDIC_function/ten_thousandths.txt", lookup_table_10000, 0, (2**ROM_ADDR_BITS)-1);
      $readmemh("C:/Users/19259/Documents/EGCP446/CORDIC_function/hundred_thousandths.txt", lookup_table_100000, 0, (2**ROM_ADDR_BITS)-1);
      $readmemh("C:/Users/19259/Documents/EGCP446/CORDIC_function/millionths.txt", lookup_table_1000000, 0, (2**ROM_ADDR_BITS)-1);
	end
   always @(posedge clk) begin
         output_data_10      <= lookup_table_10[address];
         output_data_100     <= lookup_table_100[address];
         output_data_1000    <= lookup_table_1000[address];
         output_data_10000   <= lookup_table_10000[address];
         output_data_100000  <= lookup_table_100000[address];
         output_data_1000000 <= lookup_table_1000000[address];	 
   end
				
				
    assign address = addr;
    assign tenths              = output_data_10;     
    assign hundredths          = output_data_100;    
    assign thousandths         = output_data_1000;   
    assign ten_thousandths     = output_data_10000;  
    assign hundred_thousandths = output_data_100000; 
    assign millionths = output_data_1000000;

endmodule