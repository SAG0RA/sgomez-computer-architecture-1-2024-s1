module Memory_Stage_tb;

    // Declaración de variables
    logic clk;
    logic [15:0] ALUresult;
    logic wm_in;
    logic ni_in;
    logic [15:0] y;
    logic [15:0] alu_result_memory;
	 logic [15:0] alu_result_memory1;
	 logic [15:0] memData_in;
    logic [15:0] memData_out;
	 logic [15:0] memData_out1;
    logic [15:0] muxResult;
	 logic [15:0] data1;
	 logic [15:0] data2;
    logic wm_out;
    logic ni_out;
	 logic ni_out1;
    logic wbs_out = 0;
    logic wme_out = 0;
    logic mm_out = 0;
    logic wbs_in; 

    // Instancia de ExecuteMemory_register
    ExecuteMemory_register ExecuteMemory_register_instance (
        .clk(clk),
        .wbs_in(wbs_out),
        .wme_in(wme_out),
        .mm_in(mm_out),
        .ALUresult_in(ALUresult),
        .memData_in(y), 
        .wm_in(wm_in),
        .ni_in(ni_in),
        .wbs_out(wbs_in), 
        .wme_out(wme_out),
        .mm_out(mm_out),
        .ALUresult_out(alu_result_memory),
        .memData_out(memData_out),
        .wm_out(wm_out),
        .ni_out(ni_out)
    );

    // Instancia de decoderMemory
    decoderMemory decoderMemory_instance (
        .data_in(ExecuteMemory_register_instance.ALUresult_out),
        .select(ExecuteMemory_register_instance.mm_out),
        .data_out_0(data1), 
        .data_out_1(data2)  
    );

    // Instancia de mux_2
    mux_2 mux_2_instance (
        .data0(16'b0000000000000000),
        .data1(16'b0000000000000000), 
        .select(ExecuteMemory_register_instance.wm_out),
        .out(muxResult)
    );

    // Instancia de MemoryWriteback_register
    MemoryWriteback_register MemoryWriteback_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        .memData_in(memData_in),
        .ALUresult_in(alu_result_memory),
        .ni_in(ni_in), 
        .wbs_out(wbs_out),
        .memData_out(memData_out1),
        .ALUresult_out(alu_result_memory1),
        .ni_out(ni_out1)
    );


    // Generar el clock
    always #10 clk = ~clk;

endmodule
