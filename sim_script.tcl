	vlib work
	vmap work work
	
		vlog -work work cordic.v
		vlog -work work cordic_tb.sv
		
		vsim work.cordic_tb

        source wave.do
		
		run 200ns