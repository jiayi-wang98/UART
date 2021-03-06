`timescale 1ns/10ps
module UART_tb;

logic s_clk;
logic rst;
logic tx_rx;
logic [7:0] data_tx,data_rx;
logic en,data_ready,tx_ready;

UART_TX tx(.data_i(data_tx),.s_clk_i(s_clk),.rst_i(rst),.en_i(en),.tx_o(tx_rx),.tx_ready_o(tx_ready));

UART_RX rx(.rx_i(tx_rx), .s_clk_i(s_clk),.rst_i(rst),.data_o(data_rx),.data_ready_o(data_ready));

always #5 s_clk<=~s_clk;

initial begin
	s_clk<=1'b0;
	rst<=1'b1;
	en<=1'b0;
	data_tx<=8'b10101010;
	@(negedge s_clk) rst<=1'b0;
	@(negedge s_clk) en<=1'b1;
	#80 en<=1'b0;
	#1600 data_tx<=8'b01010101;
	@(negedge s_clk) en<=1'b1;
	#80 en<=1'b0;
	#1600 en<=1'b1;
end
endmodule