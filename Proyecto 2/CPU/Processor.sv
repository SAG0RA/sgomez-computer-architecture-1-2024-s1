module Processor (input logic clk, reset,
			  output logic [31:0] WriteData, DataAdr, ReadData,
			  output logic MemWrite
);

	logic [31:0] Instr, PC;

	cpu cpu(clk, 
			  reset, 
			  PC, 
			  Instr, 
			  MemWrite, 
			  DataAdr,
			  WriteData, 
			  ReadData
	);

endmodule
