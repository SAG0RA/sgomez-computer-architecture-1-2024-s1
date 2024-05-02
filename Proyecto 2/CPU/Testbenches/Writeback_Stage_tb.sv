module WriteBack_Stage_tb;
// Declaración de variables

	 logic clk;
    logic wbs_in; 
	 logic [15:0] memData_in;
	 logic [15:0] alu_result_memory;
	 logic [15:0] alu_result_memory1;
	 logic [15:0] memData_out1;
	 logic ni_in;
	 logic wbs_out = 0;
	 logic ni_out1;
	 logic [15:0] muxResult;

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
	 
	 // Instancia de mux_2
    mux_2 mux_2_instance (
        .data0(16'b0000000000000000),
        .data1(16'b0000000000000000), 
        .select(MemoryWriteback_register_instance.wbs_out),
        .out(muxResult)
    );


    // Generar el clock
    always #10 clk = ~clk;

endmodule
