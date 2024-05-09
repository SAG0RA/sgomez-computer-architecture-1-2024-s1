module decoderMemory_3outs (
    input logic [15:0] data_in,
    input logic [1:0] select,
    output logic [15:0] data_out_0,
    output logic [15:0] data_out_1,
	 output logic [15:0] data_out_2
);


	 always_comb begin
        case (select)
            2'b00: data_out_0 = data_in; // Selecciona data0 si select es 00
            2'b01: data_out_1 = data_in; // Selecciona data1 si select es 01
            2'b10: data_out_2 = data_in; // Selecciona data2 si select es 10
        endcase
    end

endmodule
