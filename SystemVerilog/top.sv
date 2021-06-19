module top (input logic clk, rst,
				output logic [31:0] ynC, ynS);

	logic [31:0] addr, addrO, rdM, rdS, rdC, addC, addS, xnC, xnS;

	Register memR(clk, rst, addrO, addr);
	
	Adder memA(addr, 32'd1, addrO);
	
	messageROM mROM(addr, rdM);
	
	sinROM sROM(addr, rdS);
	
	cosROM cROM(addr, rdC);
	
	Adder cAdd(rdC, {16'hffff, 16'b0}, addC);
	
	Adder sAdd(rdS, {16'hffff, 16'b0}, addS);
	
	Multiplier cMult(addC, rdM, xnC);
	
	Multiplier sMult(addS, rdM, xnS);
	
	Filter cFil(clk, rst, xnC, {16'b0, 16'hfe65}, {16'b0, 16'h00cd}, {16'b0, 16'h00cd}, ynC);
	
	Filter SFil(clk, rst, xnS, {16'b0, 16'hfe65}, {16'b0, 16'h00cd}, {16'b0, 16'h00cd}, ynS);
	
	//{16'b0, 16'hfe65}
	//{16'b1, 16'h019b}

endmodule 