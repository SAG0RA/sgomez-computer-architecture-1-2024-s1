module DecodeExecute_register (
    input logic clk,
    input logic wbs_in,
    input logic wme_in,
    input logic [1:0] mm_in,
    input logic [2:0] ALUop_in,
	 input logic wm_in,
	 input logic am_in,
	 input logic ni_in,
	 input logic [15:0] srcA_in,
	 input logic [15:0] srcB_in,
    output logic wbs_out,
    output logic wme_out,
    output logic [1:0] mm_out,
    output logic [2:0] ALUop_out,
	 output logic wm_out,
	 output logic am_out,
	 output logic ni_out,
	 output logic [15:0] srcA_out,
	 output logic [15:0] srcB_out
);

    logic wbs;
    logic wme;
    logic [1:0] mm;
    logic [2:0] ALUop;
	 logic wm;
	 logic am;
	 logic ni;
	 logic [15:0] srcA;
	 logic [15:0] srcB;
    
    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
        wme <= wme_in;
        mm <= mm_in;
        ALUop <= ALUop_in;
		  wm <= wm_in;
		  am <= am_in;
		  ni <= ni_in;
		  srcA <= srcA_in;
		  srcB <= srcB_in;
    end

    // Salidas del registro
    assign wbs_out = wbs;
    assign wme_out = wme;
    assign mm_out = mm;
    assign ALUop_out = ALUop;
	 assign wm_out = wm;
	 assign am_out = am;
	 assign ni_out = ni;
	 assign srcA_out = srcA;
	 assign srcB_out = srcB;

endmodule
