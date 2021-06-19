module Multiplier_tb();

	logic [31:0] A, B, C;

	Multiplier DUT(A, B, C);
	
	initial
		begin
		
			A[31:16] = 16'd1;
			A[15:0] = 16'd32768;
			B[31:16] = 16'd3;
			B[15:0] = 16'd16384;
			
			#10;
			
			A[31:16] = 16'hfffc;
			A[15:0] = 16'd32768;
			B[31:16] = 16'd4;
			B[15:0] = 16'd32768;
			
			#10;
			
			A[31:16] = 16'hfffc;
			A[15:0] = 16'd32768;
			B[31:16] = 16'hfffc;
			B[15:0] = 16'd32768;
			
			#10;
		
		end

endmodule 