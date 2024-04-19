module microarchitecture(input logic clk, vga_clk, reset, enable,
			  output logic [31:0] WriteData, DataAdr, ReadData,
			  output logic MemWrite,
			  output logic [31:0] pixel,
			  //output logic [31:0] ins
			  output logic [31:0] x
);

	logic [31:0] Instr, PC;
	logic [31:0] memAddress = 0;
		
	
	
	ROM rom(.address(PC[7:0]),
			  .clock(clk),
			  .q(Instr)
	);
	
	
	
	cpu cpu(clk, 
			  reset, 
			  PC, 
			  Instr, 
			  MemWrite, 
			  DataAdr,
			  WriteData, 
			  ReadData
	);
	
	
	
	RAM ram(.address_a(DataAdr[15:0]),
			  .address_b(memAddress[15:0]),
			  .clock(clk),
			  .data_a(WriteData),
			  .data_b(WriteData),
			  .wren_a(MemWrite),
			  .wren_b(MemWrite),
			  .q_a(ReadData),
			  .q_b(pixel)
	);
	
	
	always_ff @(posedge vga_clk) begin
		if (reset) begin
			memAddress <= 0;
		end else if (memAddress >= 65536) begin
			memAddress <= 0;
		end else if (enable) begin
			if (memAddress < 65536) begin
				memAddress <= memAddress + 1;
			end
		end
	end
	
	
	assign x = memAddress;
	
	

endmodule


