module adc_krypton(cs_n, ch[2:0], clk, dout[11:0], ctrl_reg[7:0], led[7:0]);

	input cs_n;
	output reg [7:0] ctrl_reg; //could also call it din : only bits 3, 4 and 5 are important
	output reg [7:0]led;

	input [2:0] ch;
	input wire clk;
	input [11:0] dout;
	 
	wire clk_n;
	reg count;
	reg [11:0] data; 
	
	assign clk_temp = (!cs_n) ? clk : 0;
		
	always @ (posedge cs_n or posedge clk_temp) begin // or shd it be clk?
		if(cs_n)
			count <= 0;
		else
			count <= count + 1;
	end
		
	always @ (posedge cs_n or negedge clk_temp)
		if(cs_n) begin
			ctrl_reg <= 8'b0;
			led <= 8'b0;
			data <= 12'b0;
		end
		else begin
			if(count == 3)
				ctrl_reg[5] <= ch[2];
			if(count == 4)
				ctrl_reg[4] <= ch[1];
			if(count == 5) begin
				ctrl_reg[3] <= ch[0];
				data[11] <= dout[11];
			end
			if(count == 6)
				data[10] <= dout[10];
			else if(count == 7)
				data[9] <= dout[9];
			else if(count == 8)
				data[8] <= dout[8];
			else if(count == 9)
				data[7] <= dout[7];
			else if(count == 10)
				data[6] <= dout[6];
			else if(count == 11)
				data[5] <= dout[5];
			else if(count == 12)
				data[4] <= dout[4];
			else if(count == 13)
				data[3] <= dout[3];
			else if(count == 14)
				data[3] <= dout[2];
			else if(count == 15)
				data[2] <= dout[1];
			else if(count == 16)
				data[1] <= dout[0];
			else if(count == 1) begin 
				led[7:0] <= data[11:4];
			end
		end
	endmodule
	
			
			
			