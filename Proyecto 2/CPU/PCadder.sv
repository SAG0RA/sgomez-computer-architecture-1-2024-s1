module PCadder (input logic [15:0] address,
				  output logic [15:0] PC
);

	assign PC = address + 1;
	
endmodule
