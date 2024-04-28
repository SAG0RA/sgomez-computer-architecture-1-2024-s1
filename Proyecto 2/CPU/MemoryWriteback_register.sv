module MemoryWriteback_register (
    input logic clk,
    input logic wbs_in,
    input logic [15:0] memData_in,
	 input logic [15:0] ALUresult_in,
	 
    output logic wbs_out,
	 output logic [15:0] memData_out,
	 output logic [15:0] ALUresult_out 
);

    logic wbs;
	 logic [15:0] memData;
	 logic [15:0] ALUresult;
    

    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
		  memData <= memData_in;
		  ALUresult <= ALUresult_in;
    end

    // Salidas del registro
    assign wbs_out = wbs;
	 assign memData_out = memData;
    assign ALUresult_out = ALUresult;
    

endmodule
