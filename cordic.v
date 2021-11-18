`timescale 1ns/1ps

module cordic #(parameter number_of_iterations = 6) //latency = number of iterations
             (
               input clk,
			   input [16:0] beta,
			   output reg [16:0] sin,
			   output reg [16:0] cos
			 );
			 
	localparam PI_DIV_4 = 17'b00110010010000111;
	localparam ONE = 17'b01_000000000000000;		
	localparam X_INIT = ONE; 
	localparam Y_INIT = 17'b0;     
	wire signed [16:0] di              [number_of_iterations - 1:0];
	wire signed [33:0] mult_resi       [number_of_iterations - 1:0];
	wire signed [16:0] cumulative_tmpi [number_of_iterations - 1:0];
	reg  signed [16:0] anglei          [number_of_iterations - 1:0];
	reg  signed [16:0] betai           [number_of_iterations - 1:0];
	
    wire signed [33:0] x_product_tmp   [number_of_iterations - 1:0];
    wire signed [33:0] y_product_tmp   [number_of_iterations - 1:0];
	
    wire signed [16:0] x_shift_val   [number_of_iterations - 1:0];
    wire signed [16:0] y_shift_val   [number_of_iterations - 1:0];	
	
    wire signed [16:0] x_i_plus_1      [number_of_iterations - 1:0];
    wire signed [16:0] y_i_plus_1      [number_of_iterations - 1:0];
    reg  signed [16:0] x_i_reg         [number_of_iterations - 1:0];
    reg  signed [16:0] y_i_reg         [number_of_iterations - 1:0];
	wire signed [33:0] x_k_product, y_k_product;
	
	reg  signed [16:0] angle_neg1 = PI_DIV_4;
	
	
	genvar g;
	
    reg signed [16:0] angles [15:0];
    initial 
      begin
        angles[ 0] = 17'b00110010010000111;
        angles[ 1] = 17'b00011101101011000;
        angles[ 2] = 17'b00001111101011011;
        angles[ 3] = 17'b00000111111101010;
        angles[ 4] = 17'b00000011111111101;
        angles[ 5] = 17'b00000001111111111;
        angles[ 6] = 17'b00000000111111111;
        angles[ 7] = 17'b00000000011111111;
        angles[ 8] = 17'b00000000001111111;
        angles[ 9] = 17'b00000000000111111;
        angles[10] = 17'b00000000000011111;
        angles[11] = 17'b00000000000001111;
        angles[12] = 17'b00000000000001000;
        angles[13] = 17'b00000000000000100;
        angles[14] = 17'b00000000000000010;
        angles[15] = 17'b00000000000000001;
    end  

    reg signed [16:0] Ki_values [15:0];
    initial 
      begin
        Ki_values[ 0] = 17'b00101101010000010;
        Ki_values[ 1] = 17'b00101000011110100;
        Ki_values[ 2] = 17'b00100111010001001;
        Ki_values[ 3] = 17'b00100110111101110;
        Ki_values[ 4] = 17'b00100110111000111;
        Ki_values[ 5] = 17'b00100110110111101;
        Ki_values[ 6] = 17'b00100110110111011;
        Ki_values[ 7] = 17'b00100110110111010;
        Ki_values[ 8] = 17'b00100110110111010;
        Ki_values[ 9] = 17'b00100110110111010;
        Ki_values[10] = 17'b00100110110111010;
        Ki_values[11] = 17'b00100110110111010;
        Ki_values[12] = 17'b00100110110111010;
        Ki_values[13] = 17'b00100110110111010;
        Ki_values[14] = 17'b00100110110111010;
        Ki_values[15] = 17'b00100110110111010;

    end   	
	
	
	//stage 0 combinatorial
	assign di[0] = (beta < 0) ? 17'b11_000000000000000 : 17'b01_000000000000000;
	assign mult_resi[0] = angles[0] * di[0];
	assign cumulative_tmpi[0] = beta - mult_resi[0][31:15];
	assign x_shift_val[0] = di[0] >>> 0;
	assign y_shift_val[0] = di[0] >>> 0;
	assign x_product_tmp[0] = Y_INIT * x_shift_val[0];
	assign y_product_tmp[0] = X_INIT * y_shift_val[0];	
	assign x_i_plus_1[0] = X_INIT - x_product_tmp[0][31:15];
	assign y_i_plus_1[0] = y_product_tmp[0][31:15] - Y_INIT;
	
	
    always@(posedge clk) begin
	  //stage 0 flip flops
	  betai[0] <= cumulative_tmpi[0];
	  anglei[0] <= angles[1];
	  x_i_reg[0] <= x_i_plus_1[0];
	  y_i_reg[0] <= y_i_plus_1[0];
    end	  

	
	for(g = 1; g < number_of_iterations; g = g + 1) begin
	
	  //stage i combinatorial
	  assign di[g] = (betai[g - 1] < 0) ? 17'b11_000000000000000 : 17'b01_000000000000000;
	  assign mult_resi[g] = anglei[g - 1] * di[g];
	  assign cumulative_tmpi[g] = betai[g - 1] - mult_resi[g][31:15];
	  assign x_shift_val[g] = di[g] >>> g;
	  assign y_shift_val[g] = di[g] >>> g;
	  assign x_product_tmp[g] = y_i_reg[g - 1] * x_shift_val[g];
	  assign y_product_tmp[g] = x_i_reg[g - 1] * y_shift_val[g];	
	  assign x_i_plus_1[g] = x_i_reg[g - 1] - x_product_tmp[g][31:15];
	  assign y_i_plus_1[g] = y_product_tmp[g][31:15] + y_i_reg[g - 1];
	  always@(posedge clk) begin
	    //stage i flip flops
	    betai[g] <= cumulative_tmpi[g];
		anglei[g] <= angles[g + 1];
		x_i_reg[g] <= x_i_plus_1[g];
	    y_i_reg[g] <= y_i_plus_1[g];
	  end
	  
	end

	assign y_k_product = y_i_reg[number_of_iterations - 1] * Ki_values[number_of_iterations];
	assign x_k_product = x_i_reg[number_of_iterations - 1] * Ki_values[number_of_iterations];
	
	always@(posedge clk) begin
	  sin <= y_k_product[31:15];
	  cos <= x_k_product[31:15];
	end
			 
endmodule			 