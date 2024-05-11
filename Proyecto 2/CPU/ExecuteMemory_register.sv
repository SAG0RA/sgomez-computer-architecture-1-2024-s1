module ExecuteMemory_register (
    input logic clk,
    input logic wbs_in,
    input logic [1:0] mm_in,
	 input logic [15:0] ALUresult_in,
    input logic [15:0] memData_in,
	 input logic wm_in,
	 input logic ni_in,
	 
	 input logic wce_in,
	 input logic wme1_in,
	 input logic wme2_in,
	 input logic reg_dest_in,
	 input logic [3:0] reg_dest_data_writeback_in,
	 
	 input logic wre_in,
	 
    output logic wbs_out,
    output logic [1:0] mm_out,
	 output logic [15:0] ALUresult_out,
	 output logic [15:0] memData_out,
	 output logic wm_out,
	 output logic ni_out,

	 output logic wce_out,
	 output logic wme1_out,
	 output logic wme2_out,
	 output logic reg_dest_out,
	 output logic [3:0] reg_dest_data_writeback_out,
	 
	 output logic wre_out
);

    logic wbs;
    logic [1:0] mm;
	 logic [15:0] ALUresult;
	 logic [15:0] memData;
	 logic wm;
	 logic ni;
	 
	 logic wce;
	 logic wme1;
	 logic wme2;
	 logic reg_dest;
	 logic [3:0] reg_dest_data_writeback;
	 
	 logic wre;
    

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
		  reg_dest <= reg_dest_in;
		  reg_dest_data_writeback <= reg_dest_data_writeback_in;
		  
		  wre <= wre_in;
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
	 assign reg_dest_out = reg_dest;
	 assign reg_dest_data_writeback_out = reg_dest_data_writeback;
	 
	 assign wre_out = wre;
endmodule
