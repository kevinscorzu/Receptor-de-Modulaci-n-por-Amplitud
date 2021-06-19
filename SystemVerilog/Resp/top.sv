module top (input logic clk, rst,
				output logic [63:0] ynC, ynS);

	logic [63:0] addr, addrO, rdM, rdS, rdC, addC, addS, xnC, xnS;

	Register memR(clk, rst, addrO, addr);
	
	Adder memA(addr, 64'd1, addrO);
	
	messageROM mROM(addr, rdM);
	
	sinROM sROM(addr, rdS);
	
	cosROM cROM(addr, rdC);
	
	Adder cAdd(rdC, {32'hffffffff, 32'b0}, addC);
	
	Adder sAdd(rdS, {32'hffffffff, 32'b0}, addS);
	
	Multiplier cMult(addC, rdM, xnC);
	
	Multiplier sMult(addS, rdM, xnS);
	
	Filter cFil(clk, rst, xnC, {32'b1, 20'h019a4, 12'b0}, {40'b0, 12'hcd4, 12'b0}, {40'b0, 12'hcd4, 12'b0}, ynC);
	
	Filter SFil(clk, rst, xnS, {32'b1, 20'h019a4, 12'b0}, {40'b0, 12'hcd4, 12'b0}, {40'b0, 12'hcd4, 12'b0}, ynS);
	
	//{40'b0, 12'hcd4, 12'b0}

endmodule 