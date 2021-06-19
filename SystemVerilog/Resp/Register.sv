module Register (input logic clk, rst,
					  input logic [63:0] dataIn,
					  output logic [63:0] dataOut);

	always @(posedge clk, posedge rst)
		begin
			if (rst)
				dataOut = 64'd0;
			else
				dataOut = dataIn;
		end

			
					  
endmodule 