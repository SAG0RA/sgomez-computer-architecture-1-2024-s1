module TopModule(
			  input logic clk,
			  input logic rst,
			  output logic vga_clk,
			  output logic h_sync, v_sync,
			  output logic sync_b, blank_b,
			  output logic [7:0] red, green, blue
);
			  
	logic [9:0] x, y;
	logic [31:0] pixel;
	logic reset = 1'b0;
	
	logic enable = 1'b1;
	
	assign enable = (x < 256 & x >= 0) & (y < 256 & y >= 0);
	
	pll vga_pll(.clk(clk), .vga_clk(vga_clk));
	
	vga_controller vgaCont(vga_clk, h_sync, v_sync, sync_b, blank_b, x, y);
	
	generate_graphic gen_grid(x, y, pixel[7:0], red, green, blue);
	
	
	microarchitecture micro_arch(.clk(clk), 
					 .vga_clk(vga_clk),
					 .reset(reset),
					 .enable(enable),
					 .pixel(pixel)
	);	
	
	
	
	
endmodule
