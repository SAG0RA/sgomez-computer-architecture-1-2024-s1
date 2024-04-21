module decoder(
    input logic [15:0] Instr,
    output logic [1:0] FlagW,
    output logic PCSrc, 
    output logic RegWrite, 
    output logic MemWrite,
    output logic MemtoReg, 
    output logic ALUSrc,
    output logic [1:0] ImmSrc, 
    output logic [1:0] RegSrc, 
    output logic [1:0] ALUControl
);
    // Control signals for different instructions
    logic [9:0] controls;
    logic [3:0] OpCode;
    logic [3:0] Rd;
    logic [3:0] Rs1;
    logic [3:0] Rs2;
    logic [7:0] Imma; 
    // Extract fields from instruction
    assign {OpCode, Rd, Rs1, Rs2, Imma} = {Instr[15:12], Instr[11:8], Instr[7:4], Instr[3:0], Instr[11:4]};
    // Main Decoder
    always_comb begin
		  ALUControl = 2'b00; 
        case(OpCode)
            // Tipo R
            // ADD
            4'b0000: begin
                controls = 10'b0000001001;
                ALUControl = 2'b00; // ADD
            end
            // SUB
            4'b0001: begin
                controls = 10'b0000001001;
                ALUControl = 2'b01; // SUB
            end
            // NEG
            4'b1010: begin
                controls = 10'b0000101001; 
                ALUControl = 2'b01; // SUB
            end

            // Tipo J
            // BEQ
            4'b0010: controls = 10'b0110100010;
            // BGT
            4'b0011: controls = 10'b0110100010;
            // BLT
            4'b0100: controls = 10'b0110100010;
            // B
            4'b0101: controls = 10'b0110100010; 

            // Tipo I
            // MOV
            4'b0110: controls = 10'b0000001001; 
            // LDR
            4'b0111: controls = 10'b0001111000;
            // LSL
            4'b1000: controls = 10'b0000001001; 
            // STR
            4'b1001: controls = 10'b1001110100;

            default: controls = 10'bx;
        endcase
    end

    // Assign control signals
    assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegWrite, MemWrite, PCSrc} = controls[9:3];
    assign FlagW = controls[2:1];

endmodule
