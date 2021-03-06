`timescale 1ns/10ps
//UART_TX
//The s_clk_i is configured to be (clks_per_bit) higher than the baud rate. (oversample)
module UART_TX (input logic [7:0]data_i,
		input logic s_clk_i,rst_i,en_i,
		output logic tx_o,
		output logic tx_ready_o);

	localparam [1:0]state_idle=2'b00,
		state_start=2'b01,
		state_data=2'b10,
		state_stop=2'b11;
		
	logic [1:0] state,next_state;
	logic [2:0] bit_count;
	logic [3:0] count;// store times of samples
	
	
	
	always_ff@(posedge s_clk_i,posedge rst_i) begin
		if (rst_i) begin
			state<=state_idle;
			count<=4'h0;
		end else begin
			state<=next_state;
			if (|state==1'b1) begin //begin count when starting to transmit data
				if (count==4'hf) count<=4'h0;
				else count<=count+4'h1;
			end else count<=4'h0;
		end
	end

	always_ff@(posedge s_clk_i,posedge rst_i) begin
		if (rst_i) bit_count<=3'd0;
		else begin
			if (state!=state_data) bit_count<=3'd0; 
			else if (count==4'hf ) bit_count<=bit_count+3'd1;
		end
	end


	always_ff@(posedge s_clk_i,posedge rst_i) begin
		if(rst_i) begin
			tx_o<=1'b0;
			tx_ready_o<=1'b1;
		end else begin
			tx_o<=1'b1;
			tx_ready_o<=1'b0;
			case(state)
				state_idle:tx_ready_o<=1'b1;
				state_start:tx_o<=1'b0;
				state_data:case(bit_count)
					3'd0:tx_o<=data_i[7];
					3'd1:tx_o<=data_i[6];
					3'd2:tx_o<=data_i[5];
					3'd3:tx_o<=data_i[4];
					3'd4:tx_o<=data_i[3];
					3'd5:tx_o<=data_i[2];
					3'd6:tx_o<=data_i[1];
					3'd7:tx_o<=data_i[0];
					default:tx_o<=1'b0;
				endcase
				state_stop:tx_o<=1'b1;
				default:begin
				end
			endcase
		end
	end

		

	always_comb begin
		case (state)
			state_idle:begin
					if(en_i) next_state=state_start;
					else next_state=state_idle;
			end
			state_start: begin
					if (count==4'hf) next_state=state_data;
					else next_state=state_start;
			end
			state_data: begin
					if (count==4'hf & bit_count==3'd7) next_state=state_stop;
					else next_state=state_data;
			end
			state_stop: begin
					if (count==4'hf) next_state=en_i?state_start:state_idle;
					else next_state=state_stop;
			end
			default:next_state=state_idle;
		endcase
	end

endmodule
	
module UART_TX_tb;

logic s_clk, tx,rst,en;
logic [7:0]data;
logic tx_ready;

UART_TX dut(.data_i(data),.s_clk_i(s_clk),.rst_i(rst),.en_i(en),.tx_o(tx),.tx_ready_o(tx_ready));


always #5 s_clk<=~s_clk;

initial begin
	s_clk<=1'b0;
	rst<=1'b1;
	en<=1'b0;
	data<=8'b10101010;
	@(negedge s_clk) rst<=1'b0;
	@(negedge s_clk) en<=1'b1;
	#80 en<=1'b0;
	#1600 data<=8'b01010101;
	@(negedge s_clk) en<=1'b1;
	#80 en<=1'b0;
	#1600 en<=1'b1;
end
endmodule
