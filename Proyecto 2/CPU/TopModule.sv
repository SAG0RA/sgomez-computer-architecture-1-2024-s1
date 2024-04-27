module TopModule;

    // Definición de señales
    logic clk;
    logic wre;
    logic [3:0] a1, a2, a3;
    logic [15:0] wd3;
    logic [15:0] rd1, rd2, rd3;
	 
    logic [15:0] a, b, y;
	 
    logic [1:0] ALUop = 1;
	 
    logic [7:0] Immediate = 8'b10000000;
    logic [15:0] SignExtImmediate;
    logic [15:0] ZeroExtImmediate;
    
    // Instanciar el módulo regfile
    regfile regfile_instance (
        .clk(clk),
        .wre(wre),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2),
        .rd3(rd3)
    );
    
    // Instanciar el módulo ALU
    ALU ALU_instance (
        .ALUop(ALUop), 
        .srcA(a),
        .srcB(b),
        .ALUresult(y)
    );
    
    // Instanciar el módulo signExtend
    signExtend signExtend_instance (
        .Immediate(Immediate),
        .SignExtImmediate(SignExtImmediate)
    );

    // Instanciar el módulo zeroExtend
    zeroExtend zeroExtend_instance (
        .Immediate(Immediate),
        .ZeroExtImmediate(ZeroExtImmediate)
    );
    
endmodule
