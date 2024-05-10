module ExecuteMemory_register (
    input logic clk,
    input logic wbs_in,
    //input logic wme_in,
    input logic [1:0] mm_in,
	 input logic [15:0] ALUresult_in,
    input logic [15:0] memData_in,
	 input logic wm_in,
	 input logic ni_in,
	 
	 input logic wce_in,
	 input logic wme1_in,
	 input logic wme2_in,
	 
    output logic wbs_out,
    //output logic wme_out,
    output logic [1:0] mm_out,
	 output logic [15:0] ALUresult_out,
	 output logic [15:0] memData_out,
	 output logic wm_out,
	 output logic ni_out,

	 output logic wce_out,
	 output logic wme1_out,
	 output logic wme2_out
);

    logic wbs;
    //logic wme;
    logic [1:0] mm;
	 logic [15:0] ALUresult;
	 logic [15:0] memData;
	 logic wm;
	 logic ni;
	 
	 logic wce;
	 logic wme1;
	 logic wme2;
    

    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
        //wme <= wme_in;
        mm <= mm_in;
		  ALUresult <= ALUresult_in;
		  memData <= memData_in;
		  wm <= wm_in;
		  ni <= ni_in; 
		 
		  wce <= wce_in; 
		  wme1 <= wme1_in;
		  wme2 <= wme2_in;
    end

    // Salidas del registro
    assign wbs_out = wbs;
    //assign wme_out = wme;
    assign mm_out = mm;
	 assign ALUresult_out = ALUresult;
	 assign memData_out = memData;
	 assign wm_out = wm;
	 assign ni_out = ni;
	 
	 assign wce_out = wce;
	 assign wme1_out = wme1;
	 assign wme2_out = wme2;
endmodule
