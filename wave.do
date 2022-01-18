onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_tb/s_clk
add wave -noupdate /UART_tb/rst
add wave -noupdate /UART_tb/tx_rx
add wave -noupdate /UART_tb/en
add wave -noupdate /UART_tb/data_tx
add wave -noupdate /UART_tb/data_rx
add wave -noupdate /UART_tb/data_ready
add wave -noupdate /UART_tb/tx_ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3589930 ps} 0}
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
WaveRestoreZoom {2989810 ps} {3739230 ps}
