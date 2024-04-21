module datapath(
    input logic clk, 
    input logic reset,
    input logic [1:0] RegSrc,
    input logic RegWrite,
    input logic [1:0] ImmSrc,
    input logic ALUSrc,
    input logic [1:0] ALUControl,
    input logic MemtoReg,
    input logic PCSrc,
    output logic [3:0] ALUFlags,
    output logic [31:0] PC,
    input logic [15:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input logic [31:0] ReadData
);

    // Declaración de señales internas
    logic [31:0] PCNext, PCPlus4, PCPlus8; // PCNext es el próximo valor del contador de programa (PC)
    logic [31:0] ExtImm, SrcA, SrcB, Result; // ExtImm es el inmediato extendido, SrcA y SrcB son las fuentes de datos para la ALU, Result es el resultado de la ALU
    logic [3:0] RA1, RA2; // RA1 y RA2 son las direcciones de los registros de lectura
    
    // Lógica del siguiente PC
    mux2 #(32) pcmux(
        .A(PCPlus4), 
        .B(Result), 
        .sel(PCSrc), 
        .Y(PCNext)
    ); // Selecciona el próximo PC basado en la instrucción actual y la señal de control PCSrc
    
    flopr #(32) pcreg(
        .clk(clk), 
        .reset(reset), 
        .D(PCNext), 
        .Q(PC)
    ); // Registra el próximo PC
    
    adder #(32) pcadd1(
        .A(PC), 
        .B(32'h100), 
        .Sum(PCPlus4)
    ); // Suma 4 al PC actual para obtener el próximo PC
    
    adder #(32) pcadd2(
        .A(PCPlus4), 
        .B(32'h100), 
        .Sum(PCPlus8)
    ); // Suma 8 al PCPlus4 para obtener la dirección de memoria siguiente
    
    // Lógica del registro de archivos
    mux2 #(4) ra1mux(
        .A(Instr[19:16]), 
        .B(4'hf), 
        .sel(RegSrc[0]), 
        .Y(RA1)
    ); // Selecciona la dirección del primer registro basado en la instrucción y la señal de control RegSrc
    
    mux2 #(4) ra2mux(
        .A(Instr[3:0]), 
        .B(Instr[15:12]), 
        .sel(RegSrc[1]), 
        .Y(RA2)
    ); // Selecciona la dirección del segundo registro basado en la instrucción y la señal de control RegSrc
    
    regfile rf(
        .clk(clk), 
        .wr_en(RegWrite), 
        .addr1(RA1), 
        .addr2(RA2), 
        .wr_data(Instr[15:0]), 
        .rd_data(Result), 
        .mem_addr(PCPlus8), 
        .rd1_data(SrcA), 
        .rd2_data(WriteData)
    ); // Acceso al registro de archivos para lectura y escritura
    
    mux2 #(32) resmux(
        .A(ALUResult), 
        .B(ReadData), 
        .sel(MemtoReg), 
        .Y(Result)
    ); // Selecciona el dato a escribir en el registro de destino basado en la señal de control MemtoReg
    
    extend ext(
        .A(Instr[23:0]), 
        .sel(ImmSrc), 
        .Y(ExtImm)
    ); // Extiende el inmediato según el tipo de instrucción
    
    // Lógica de la ALU
    mux2 #(32) srcbmux(
        .A(WriteData), 
        .B(ExtImm), 
        .sel(ALUSrc), 
        .Y(SrcB)
    ); // Selecciona la segunda fuente de datos para la ALU (registro o inmediato) basado en ALUSrc
    
    alu alu(
        .A(SrcA), 
        .B(SrcB), 
        .Control(ALUControl), 
        .Result(ALUResult), 
        .Flags(ALUFlags)
    ); // Ejecuta la operación ALU y calcula las banderas
endmodule
