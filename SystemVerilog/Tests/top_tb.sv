module top_tb();

	logic clk, rst;
	logic[31:0] ynC, ynS;

	top DUT(clk, rst, ynC, ynS);
	
	initial
		begin
			clk = 1'b1;
			rst = 1'b1;
			
			#2;
			
			rst = 1'b0;
		end
		
	always
		begin
			#1;
			clk = ~clk;
		end
		
	// synthesis translate_off
	
	int i, m1, m2;	
	initial
		begin
			m1 = $fopen("message1.txt", "w");
			m2 = $fopen("message2.txt", "w");
			i = 'd0;
			
			while (i < 'd100000)
				begin
					@(negedge clk);
						begin
							$fwrite(m1, "%b\n", ynC);
							$fwrite(m2, "%b\n", ynS);
							i += 1;
						end
				end
			
			$fclose(m1);
			$fclose(m2);
			$finish;
		end
		
	// synthesis translate_on

endmodule 