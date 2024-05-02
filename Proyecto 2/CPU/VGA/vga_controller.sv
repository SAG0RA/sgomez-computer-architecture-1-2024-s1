module vga_controller #(
							parameter HACTIVE = 10'd256,
							//parameter HACTIVE = 10'd250,
							HFP = 10'd192,
							HSYN = 10'd48,
							HBP = 10'd192,
							HMAX = HACTIVE + HFP + HSYN + HBP,
							VBP = 10'd112,
							VACTIVE = 10'd256,
							//VACTIVE = 10'd250,
							VFP = 10'd112,
							VSYN = 10'd2,
							VMAX = VACTIVE + VFP + VSYN + VBP)
							(input logic vga_clk,
							output logic h_sync, v_sync, sync_b, blank_b,
							output logic [9:0] x, y);

	initial begin
		 x = 0;
		 y = 0;
	end


	// counters for horizontal and vertical positions
	always @(posedge vga_clk) begin
		x++;
		if (x == HMAX) begin
			x = 0;
			y++;
		if (y == VMAX) y = 0;
		end
	end

	// Compute sync signals (active low)
	assign h_sync = ~(x >= HACTIVE + HFP & x < HACTIVE + HFP + HSYN); // Cambio de hcnt a x
	assign v_sync = ~(y >= VACTIVE + VFP & y < VACTIVE + VFP + VSYN); // Cambio de vcnt a y
	assign sync_b = h_sync & v_sync;
	// Force outputs to black when outside the legal display area
	assign blank_b = (x < HACTIVE) & (y < VACTIVE); // Cambio de hcnt y vcnt a x y y

endmodule