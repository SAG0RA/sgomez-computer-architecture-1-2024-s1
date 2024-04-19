module microarchitecture(input logic clk, vga_clk, reset, enable, 
			  output logic [31:0] pixel
			  
);

	logic [31:0] memAddress = 32'b0;
	logic	[31:0]  data;
	logic	[15:0]  rdaddress;
	logic	[15:0]  wraddress;
	logic	  wren = 1'b0;
		
	
	/*
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
	*/
	
	
	RAM ram(.clock(clk),
			  .data(WriteData),
			  .rdaddress(memAddress),
			  .wraddress(MemWrite),
			  .wren(wren),
			  .q(pixel)
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
	
	
	//assign x = memAddress;
	
	

endmodule


