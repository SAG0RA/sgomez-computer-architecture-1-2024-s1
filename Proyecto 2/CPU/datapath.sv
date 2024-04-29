module datapath (
	input logic [15:0] instruction
);

	logic [1:0] ALUop = 1;
	logic [15:0] a, b, y;
	logic flagN;
	logic flagZ;

	ALU ALU_instance (
        .ALUop(ALUop), 
        .srcA(a),
        .srcB(b),
        .ALUresult(y),
		  .flagN(flagN),
		  .flagZ(flagZ)
    );


endmodule
