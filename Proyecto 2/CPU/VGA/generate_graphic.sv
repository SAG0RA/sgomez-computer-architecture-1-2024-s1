module generate_graphic (
  input logic [9:0] x, y,
  input logic [7:0] ReadData,
  output logic [7:0] red, green, blue
);

  logic inrectBGLeft;
  logic inrectBGRight;
  logic inrectImage;
	 
  
  generate_rectangle rectImage(x, y, 0, 0, 10'd256, 10'd256, inrectImage);
  
  always_comb begin
    red   = (inrectImage ? ReadData : 8'b01010101);
    green = (inrectImage ? ReadData : 8'b01010101);
    blue  = (inrectImage ? ReadData : 8'b01010101);
  end

endmodule