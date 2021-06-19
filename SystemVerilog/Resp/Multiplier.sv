module Multiplier (input logic [63:0] A, B,
						 output logic [63:0] C);
	
	logic [63:0] AAux, BAux;
	logic [62:0] high, highAux, mid, midAux1, midAux2, low, lowAux, CAux;
	logic [30:0] a, c;
	logic [31:0] b, d;
	logic sign;
	
	always_comb
		begin
			if (A[63])
				AAux = ~(A) + 1'd1;
			else
				AAux = A;
		end
		
	always_comb
		begin
			if (B[63])
				BAux = ~(B) + 1'd1;
			else
				BAux = B;				
		end
	
	assign a = AAux[62:32];
	assign b = AAux[31:0];
	assign c = BAux[62:32];
	assign d = BAux[31:0];
	
	assign high = a * c;
	assign highAux = high << 32;
	
	assign midAux1 = (a * d);
	assign midAux2 = (b * c);
	assign mid = midAux1 + midAux2;
	
	assign low = b * d;
	assign lowAux = low >> 32;
	
	assign sign = A[63] ^ B[63];
	
	assign CAux = highAux + mid + lowAux;
	
	always_comb
		begin
			if (CAux == 63'd0)
				C = 64'd0;
			else if (sign)
				C = {1'd1, ~(CAux) + 1'd1};
			else
				C = {1'd0, CAux};
		end
						 
endmodule 