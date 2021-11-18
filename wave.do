onerror {resume}
radix define fixed_point -fixed -fraction 15 -signed -base signed -precision 6
radix define tmp_fixed_point -fixed -fraction 30 -signed -base signed -precision 6
quietly WaveActivateNextPane {} 0
add wave -noupdate /cordic_tb/clk
add wave -noupdate -radix fixed_point /cordic_tb/beta
add wave -noupdate -radix fixed_point /cordic_tb/sin
add wave -noupdate -radix fixed_point /cordic_tb/cos
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199418 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {210 ns}
