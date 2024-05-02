module microarchitecture(input logic clk, vga_clk, reset, enable, 
			  output logic [31:0] pixel
			  
);

	logic [15:0] read_address = 16'b0;
	logic	[7:0]  write_data;
	logic	[15:0]  write_address;
	logic	  write_enable = 1'b0;
		
	
	/*
	ROM rom(.address(PC),
			  .clock(clk),
			  .q(instruction)
	);
	
	
	
	cpu cpu(clk, 
			  reset, 
			  PC, 
			  instruction, 
			  MemWrite, 
			  DataAdr,
			  WriteData, 
			  ReadData
	);
	*/
	
	
	RAM ram(.address(read_address),
			  .clock(clk),
			  .data(write_ata),
			  .wren(write_enable),
			  .q(pixel)
	);
	
	
	always_ff @(posedge vga_clk) begin
		if (reset) begin
			read_address <= 0;
		end else if (read_address >= 65536) begin
			read_address <= 0;
		end else if (enable) begin
			if (read_address < 65536) begin
				read_address <= read_address + 1;
			end
		end
	end
	

endmodule

