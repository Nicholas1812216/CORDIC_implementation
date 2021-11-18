`timescale 1ns/1ps

module cordic_tb();
    reg clk = 0;
	reg [16:0] beta = 0;
	wire [16:0] sin;
	wire [16:0] cos;
	
	
	int i = 0, j = -1;
	
    reg signed [16:0] test_input_angles [10:0];
    reg signed [16:0] cos_val [10:0];
    reg signed [16:0] sin_val [10:0];
	
	
    initial 
      begin
        $readmemb("C:/Users/19259/Documents/EGCP446/CORDIC_function/test_values.txt",test_input_angles);
        $readmemb("C:/Users/19259/Documents/EGCP446/CORDIC_function/cos_values.txt",cos_val);
        $readmemb("C:/Users/19259/Documents/EGCP446/CORDIC_function/sin_values.txt",sin_val);		
		
    end  	
	
	cordic #(9) DUT(.*); //increase parametrization to improve accuracy, the limit is 16 iterations
	                     
			 
	always begin
	  #5 clk = 0;
	  #5 clk = 1;
	end
	
	reg signed [17:0] diff;
	shortreal error_percent_sin,error_percent_cos;
	
	always@(posedge clk) begin
	  if(i < 11) begin
	    beta <= test_input_angles[i];
	    i++;
      end
	end
	
	always@(sin,cos) begin
	  j++;
	  diff = sin_val[j] - sin;
	  error_percent_sin = 100.0 * diff / sin_val[j];
	  diff = cos_val[j] - cos;	
	  error_percent_cos = 100.0 * diff / cos_val[j];
	  if(error_percent_cos < 0) error_percent_cos *= -1;
	  if(error_percent_sin < 0) error_percent_sin *= -1;
      assert (error_percent_sin <= 5)
        else $error("Sin Percent error greater than 5 percent!");	

      assert (error_percent_cos <= 5)
        else $error("Cos Percent error greater than 5 percent!");		
		
	  
	end
	
	

   wire [7:0] T;
   T_gen tgen(.*);	
	
endmodule