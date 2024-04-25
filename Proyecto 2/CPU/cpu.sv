module cpu(
    input logic clk, 
    input logic reset,
    output logic [31:0] PC,
    input logic [15:0] Instr,
    output logic MemWrite,
    output logic [31:0] ALUResult, WriteData,
    input logic [31:0] ReadData
);

    // Estados del pipeline
    typedef enum logic [2:0] {
        FETCH,
        DECODE,
        EXECUTE,
        MEMORY_ACCESS,
        WRITE_BACK
    } PipelineState;

    // Señales de control para el pipeline
    logic [2:0] currentState, nextState;

    // Registros de pipeline
    logic [15:0] IF_ID_Instr, ID_EX_Instr, EX_MEM_Instr, MEM_WB_Instr;
    logic [31:0] IF_ID_PC, ID_EX_PC, EX_MEM_PC, MEM_WB_PC;

    // Lógica de la máquina de estados
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            currentState <= FETCH;
        end else begin
            currentState <= nextState;
        end
    end

    // Control del flujo de datos entre etapas del pipeline
    always_ff @(posedge clk or posedge reset) begin
        // Dependiendo del estado actual del pipeline, establecer el próximo estado y las señales de control
        case (currentState)
            FETCH: begin
                // Lógica para la etapa FETCH Aquí se cargan las instrucciones y las PC
                IF_ID_Instr <= Instr;
                //IF_ID_PC <= PC;
                nextState = DECODE;
            end
            DECODE: begin
                // Lógica para la etapa DECODE Aquí se decodifican las instrucciones
                ID_EX_Instr <= IF_ID_Instr;
                //ID_EX_PC <= IF_ID_PC;
                nextState = EXECUTE;
            end
            EXECUTE: begin
                // Lógica para la etapa EXECUTE Aquí se ejecutan las instrucciones
                EX_MEM_Instr <= ID_EX_Instr;
                //EX_MEM_PC <= ID_EX_PC;
                nextState = MEMORY_ACCESS;
            end
            MEMORY_ACCESS: begin
                // Lógica para la etapa MEMORY_ACCESS Aquí se accede a la memoria si es necesario
                MEM_WB_Instr <= EX_MEM_Instr;
                //MEM_WB_PC <= EX_MEM_PC;
                nextState = WRITE_BACK;
            end
            WRITE_BACK: begin
                // Lógica para la etapa WRITE_BACK Aquí se escriben los resultados de vuelta a los registros si es necesario
                // Además, se actualiza la PC
                //PC <= MEM_WB_PC;
                nextState = FETCH;
            end
        endcase
    end

    // Unidad de control
    controller c(
                    .clk(clk), 
                    .reset(reset), 
                    .IF_ID_Instr(IF_ID_Instr), 
                    .ALUFlags(ALUFlags),
                    .RegSrc(RegSrc), 
                    .RegWrite(RegWrite), 
                    .ImmSrc(ImmSrc),
                    .ALUSrc(ALUSrc), 
                    .ALUControl(ALUControl),
                    .MemWrite(MemWrite), 
                    .MemtoReg(MemtoReg), 
                    .PCSrc(PCSrc)
    );
	   // Conexión del datapath
   datapath dp(
					.clk(clk), 
					.reset(reset),
					.RegSrc(RegSrc), 
					.RegWrite(RegWrite), 
					.ImmSrc(ImmSrc),
					.ALUSrc(ALUSrc), 
					.ALUControl(ALUControl),
					.MemtoReg(MemtoReg), 
					.PCSrc(PCSrc),
					.ALUFlags(ALUFlags), 
					.PC(PC), 
					.Instr(Instr),//.Instr(MEM_WB_Instr),
					.ALUResult(ALUResult), 
					.WriteData(WriteData), 
					.ReadData(ReadData)
    );
endmodule
