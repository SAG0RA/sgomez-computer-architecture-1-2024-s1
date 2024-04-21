module microarchitecture(
    input logic clk, 
    input logic vga_clk, 
    input logic reset, 
    input logic enable,
    output logic [31:0] pixel
);

    // Declaraciones de señales
    logic [31:0] memAddress = 32'b0;
    logic [31:0] data;
    logic [15:0] rdaddress;
    logic [15:0] wraddress;
    logic wren = 1'b0;
    logic [31:0] PC;
    logic [15:0] Instr;
    logic MemWrite;
    logic [31:0] ALUResult;
    logic [31:0] WriteData;
    logic [31:0] ReadData;
    logic [3:0] ALUFlags;
    logic [1:0] RegSrc;
    logic RegWrite;
    logic [1:0] ImmSrc;
    logic ALUSrc;
    logic [1:0] ALUControl;
    logic MemtoReg;
    logic PCSrc;

    // Instanciación del CPU
    cpu cpu_inst(
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .MemWrite(MemWrite),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    // Instanciación de la ROM
    ROM rom(
        .address(PC[7:0]),
        .clock(clk),
        .q(Instr)
    );

    // Instanciación de la RAM
    RAM ram(
        .clock(clk),
        .data(WriteData),
        .rdaddress(memAddress),
        .wraddress(MemWrite),
        .wren(wren),
        .q(pixel)
    );

    // Lógica de actualización de la dirección de memoria
    always_ff @(posedge vga_clk) begin
        if (reset) begin
            memAddress <= 32'b0;
        end else if (memAddress >= 65536) begin
            memAddress <= 32'b0;
        end else if (enable) begin
            if (memAddress < 65536) begin
                memAddress <= memAddress + 1;
            end
        end
    end

endmodule
