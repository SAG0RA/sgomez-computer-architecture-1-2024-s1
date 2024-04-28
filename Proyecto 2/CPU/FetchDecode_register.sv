module FetchDecode_register (
    input logic clk, 
    input logic [15:0] instruction_in,
    output logic [15:0] instruction_out
);

    // Registro de almacenamiento de 16 bits
    logic [15:0] out;

    // Proceso de escritura en el registro
    always_ff @(posedge clk) begin
        out <= instruction_in;
    end

    // Salida del registro
    assign instruction_out = out;

endmodule
