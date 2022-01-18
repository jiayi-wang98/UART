`timescale 1ns/10ps
//UART_RX
//The s_clk_i is configured to be 16x higher than the baud rate. (oversample)
module UART_RX (input logic rx_i, s_clk_i,rst_i,
		output logic [7:0] data_o,
		output logic data_ready_o);

	localparam [3:0]state_idle=4'b0000,
		state_start=4'b0001,
		state_data_1=4'b0010,
		state_data_2=4'b0011,
		state_data_3=4'b0100,
		state_data_4=4'b0101,
		state_data_5=4'b0110,
		state_data_6=4'b0111,
		state_data_7=4'b1000,
		state_data_8=4'b1001,
		state_stop=4'b1010;
		
	logic [3:0] state,next_state;
	logic [3:0] count;// store times of samples
	
	
	always_ff@(posedge s_clk_i,posedge rst_i) begin
		if (rst_i) begin
			state<=state_idle;
			count<=4'h0;
		end else begin
			state<=next_state;
			if (|state==1'b1) begin //begin count when starting to receive data
				if (count==4'hf) count<=4'h0;
				else count<=count+4'h1;
			end else count<=4'h0;
		end
	end

	always_ff@(posedge s_clk_i,posedge rst_i) begin
		if(rst_i) begin
			data_o<=8'h00;
			data_ready_o<=1'b0;
		end else begin
			data_o<=8'h00;
			data_ready_o<=1'b0;
			case(state)
				state_data_1:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_2:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_3:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_4:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_5:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_6:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_7:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_data_8:begin
					if(count==4'd7) data_o<={data_o[6:0],rx_i};
					else data_o<=data_o;
				end
				state_stop:begin
					if(count==4'd7 & rx_i==1'b1) begin
						data_o<=data_o;
						data_ready_o<=1'b1;
					end else begin
						data_o<=data_o;
						data_ready_o<=data_ready_o;
					end
				end
				default:begin
				end
			endcase
		end
	end

		

	always_comb begin
		case (state)
			state_idle:begin
					if(rx_i==1'b0) next_state=state_start;
					else next_state=state_idle;
			end
			state_start: begin
					if (count==4'hf) next_state=state_data_1;
					else next_state=state_start;
			end
			state_data_1: begin
					if (count==4'hf) next_state=state_data_2;
					else next_state=state_data_1;
			end
			state_data_2: begin
					if (count==4'hf) next_state=state_data_3;
					else next_state=state_data_2;
			end
			state_data_3: begin
					if (count==4'hf) next_state=state_data_4;
					else next_state=state_data_3;
			end
			state_data_4: begin
					if (count==4'hf) next_state=state_data_5;
					else next_state=state_data_4;
			end
			state_data_5: begin
					if (count==4'hf) next_state=state_data_6;
					else next_state=state_data_5;
			end
			state_data_6: begin
					if (count==4'hf) next_state=state_data_7;
					else next_state=state_data_6;
			end
			state_data_7: begin
					if (count==4'hf) next_state=state_data_8;
					else next_state=state_data_7;
			end
			state_data_8: begin
					if (count==4'hf) next_state=state_stop;
					else next_state=state_data_8;
			end
			state_stop: begin
					if (count==4'hf) next_state=rx_i?state_idle:state_start;
					else next_state=state_stop;
			end
			default:next_state=state_idle;
		endcase
	end

endmodule
	
module UART_RX_tb;

logic s_clk, tx,rst;
logic [7:0]data;
logic data_ready;

UART_RX dut(.rx_i(tx), .s_clk_i(s_clk),.rst_i(rst),.data_o(data),.data_ready_o(data_ready));

always #5 s_clk<=~s_clk;

initial begin
	s_clk<=1'b0;
	rst<=1'b1;
	tx<=1'b1;
	@(negedge s_clk) rst<=1'b0;
	#80 tx<=1'b0;//start bit
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b1;//stop bit

	#320 tx<=1'b0;//start bit
	#160 tx<=1'b0;
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b1;
	#160 tx<=1'b0;
	#160 tx<=1'b0;
	#160 tx<=1'b1;//stop bit
end
endmodule

	
	


