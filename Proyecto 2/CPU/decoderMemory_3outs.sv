module decoderMemory_3outs (
    input logic [15:0] data_in,
    input logic [1:0] select,
    output logic [15:0] data_out_0,
    output logic [15:0] data_out_1,
    output logic [15:0] data_out_2
);

    always_comb begin
        case (select)
            2'b00: begin
                data_out_0 = data_in;
                data_out_1 = '0;
                data_out_2 = '0;
            end
            2'b01: begin
                data_out_0 = '0;
                data_out_1 = data_in;
                data_out_2 = '0;
            end
            2'b10: begin
                data_out_0 = '0;
                data_out_1 = '0;
                data_out_2 = data_in;
            end
            default: begin
                data_out_0 = 'x;
                data_out_1 = 'x;
                data_out_2 = 'x;
            end
        endcase
    end

endmodule
