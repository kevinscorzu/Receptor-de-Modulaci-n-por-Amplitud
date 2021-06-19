module Multiplier (input logic [31:0] A, B,
						 output logic [31:0] C);
	
	logic [31:0] AAux, BAux;
	logic [31:0] high, highAux, mid, midAux1, midAux2, low, lowAux, CAux;
	logic [14:0] a, c;
	logic [15:0] b, d;
	logic sign;
	
	always_comb
		begin
			if (A[31])
				AAux = ~(A) + 1'd1;
			else
				AAux = A;
		end
		
	always_comb
		begin
			if (B[31])
				BAux = ~(B) + 1'd1;
			else
				BAux = B;				
		end
	
	assign a = AAux[30:16];
	assign b = AAux[15:0];
	assign c = BAux[30:16];
	assign d = BAux[15:0];
	
	assign high = a * c;
	assign highAux = high << 16;
	
	assign midAux1 = (a * d);
	assign midAux2 = (b * c);
	assign mid = midAux1 + midAux2;
	
	assign low = b * d;
	assign lowAux = low >> 16;
	
	assign sign = A[31] ^ B[31];
	
	assign CAux = highAux + mid + lowAux;
	
	always_comb
		begin
			if (CAux == 32'd0)
				C = 32'd0;
			else if (sign)
				C = {1'd1, ~(CAux[30:0]) + 1'd1};
			else
				C = {1'd0, CAux[30:0]};
		end
						 
endmodule 