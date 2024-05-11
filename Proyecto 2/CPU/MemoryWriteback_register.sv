module MemoryWriteback_register (
    input logic clk,
    input logic wbs_in,
    input logic [15:0] memData_in,
	 input logic [15:0] calcData_in,
	 input logic ni_in,
	 input logic reg_dest_in,
	 input logic [3:0] reg_dest_data_writeback_in,
	 
	 input logic wre_in,
	 //input logic [3:0] opCode,
	 
    output logic wbs_out,
	 output logic [15:0] memData_out,
	 output logic [15:0] calcData_out,
	 output logic ni_out,
	 output logic reg_dest_out,
	 output logic [3:0] reg_dest_data_writeback_out,
	 
	 output logic wre_out
);

    logic wbs;
	 logic [15:0] memData;
	 logic [15:0] calcData;
	 logic ni;
	 logic reg_dest;
	 logic [3:0] reg_dest_data_writeback;
	 
	 logic wre;
    

    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
		  memData <= memData_in;
		  calcData <= calcData_in;
		  ni <= ni_in;
		  reg_dest <= reg_dest_in;
		  reg_dest_data_writeback <= reg_dest_data_writeback_in;
		  
		  wre <= wre_in;
    end

    // Salidas del registro
    assign wbs_out = wbs;
	 assign memData_out = memData;
    assign calcData_out = calcData;
    assign ni_out = ni;
	 assign reg_dest_out = reg_dest;
	 assign reg_dest_data_writeback_out = reg_dest_data_writeback;
	 assign wre_out = 1'b1;
	 
	 /*
	 always_comb begin
        case (opCode)
            4'b0000: wre_out = 1'b1; // Asigna 1 si opCode es 0000
            4'b0001: wre_out = 1'b1; // Asigna 0 si opCode es 0001
            default: wre_out = 1'b0; // Valor por defecto si opCode no coincide con ningún caso
        endcase
    end
	 */
	 
	 
endmodule
