module controller(input logic clk, 
						input logic reset,
						input logic [15:0] Instr,
						input logic [3:0] ALUFlags,
						output logic [1:0] RegSrc,
						output logic RegWrite,
						output logic [1:0] ImmSrc,
						output logic ALUSrc,
						output logic [1:0] ALUControl,
						output logic MemWrite, 
						output logic MemtoReg,
						output logic PCSrc
);

	logic [1:0] FlagW;
	logic [1:0] PCS, ImmS, Src, ALUC;
	
	decoder dec(
					.Instr(Instr),
					.FlagW(FlagW),
					.PCSrc(PCS),
					.ImmSrc(ImmS),
					.RegSrc(RegSrc),
					.ALUSrc(ALUSrc),
					.ALUControl(ALUC)
    );
	
	condlogic cl(
					.clk(clk), 
					.reset(reset), 
					.Cond(Instr[15:12]), 
					.ALUFlags(ALUFlags),
					.FlagW(FlagW), 
					.PCS(PCS), 
					.RegW(RegWrite), 
					.MemW(MemWrite),
					.PCSrc(PCSrc), 
					.RegWrite(RegWrite), 
					.MemWrite(MemWrite)
    );

endmodule
