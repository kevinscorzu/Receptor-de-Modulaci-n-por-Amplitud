module Filter (input logic clk, rst,
				   input logic [31:0] xn, a1, b0, b1,
				   output logic [31:0] yn);
			
	logic [31:0] wn, wn1, mula1, mulb0, mulb1;
	
	Adder add1(xn, mula1, wn);
	
	Multiplier mult1(wn1, a1, mula1);
	
	Multiplier mult2(wn1, b1, mulb1);
	
	Multiplier mult3(wn, b0, mulb0);
	
	Adder add2(mulb0, mulb1, yn);
	
	Register regs(clk, rst, wn, wn1);
				  
endmodule 