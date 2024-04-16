module generate_rectangle(input logic [9:0] x, y, left, top, right, bottom, output logic in_rectangle);
	assign in_rectangle = (x >= left & x < right & y >= top & y < bottom);
endmodule