onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_RX_tb/s_clk
add wave -noupdate /UART_RX_tb/tx
add wave -noupdate /UART_RX_tb/rst
add wave -noupdate /UART_RX_tb/data
add wave -noupdate /UART_RX_tb/data_ready
add wave -noupdate -radix unsigned /UART_RX_tb/dut/state
add wave -noupdate -radix unsigned /UART_RX_tb/dut/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3388830 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1220820 ps}
