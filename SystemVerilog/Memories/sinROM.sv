module sinROM (input logic [31:0] addr,
					output logic [31:0] rd);
	
	// synthesis translate_off
	
	logic [31:0] ROM[99999:0];
	
	initial
		$readmemb("sin.txt", ROM);
		
	assign rd = ROM[addr];
	
	// synthesis translate_on
	
endmodule 