module ExecuteMemory_register (
    input logic clk,
    input logic wbs_in,
    input logic wme_in,
    input logic mm_in,
	 input logic [15:0] ALUresult_in,
    input logic [15:0] memData_in,
	 input logic wm_in,
	 input logic ni_in,
	 
    output logic wbs_out,
    output logic wme_out,
    output logic mm_out,
	 output logic [15:0] ALUresult_out,
	 output logic [15:0] memData_out,
	 output logic wm_out,
	 output logic ni_out    
);

    logic wbs;
    logic wme;
    logic mm;
	 logic [15:0] ALUresult;
	 logic [15:0] memData;
	 logic wm;
	 logic ni;
    

    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
        wme <= wme_in;
        mm <= mm_in;
		  ALUresult <= ALUresult_in;
		  memData <= memData_in;
		  wm <= wm_in;
		  ni <= ni_in;  
    end

    // Salidas del registro
    assign wbs_out = wbs;
    assign wme_out = wme;
    assign mm_out = mm;
	 assign ALUresult_out = ALUresult;
	 assign memData_out = memData;
	 assign wm_out = wm;
	 assign ni_out = ni;
endmodule
