module mux_2 (input logic [15:0] data0, data1,
				  input logic select,
				  output logic [15:0] out
);

	assign out = select ? data0 : data1;

endmodule
