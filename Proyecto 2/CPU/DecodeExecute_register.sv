module DecodeExecute_register (
    input logic clk,
    input logic wbs_in,
    input logic wme_in,
    input logic mm_in,
    input logic [1:0] ALUop_in,
    output logic wbs_out,
    output logic wme_out,
    output logic mm_out,
    output logic [1:0] ALUop_out
);

    logic wbs;
    logic wme;
    logic mm;
    logic [1:0] ALUop;
    
    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        wbs <= wbs_in;
        wme <= wme_in;
        mm <= mm_in;
        ALUop <= ALUop_in;
    end

    // Salidas del registro
    assign wbs_out = wbs;
    assign wme_out = wme;
    assign mm_out = mm;
    assign ALUop_out = ALUop;

endmodule
