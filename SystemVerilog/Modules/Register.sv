module Register (input logic clk, rst,
					  input logic [31:0] dataIn,
					  output logic [31:0] dataOut);

	always @(posedge clk, posedge rst)
		begin
			if (rst)
				dataOut = 32'd0;
			else
				dataOut = dataIn;
		end

			
					  
endmodule 