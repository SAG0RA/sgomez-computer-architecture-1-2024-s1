module ALU (
    input logic [2:0] ALUop, // Entrada de control para la operación ALU
    input logic [15:0] srcA, // Primer operando
    input logic [15:0] srcB, // Segundo operando
    output logic [15:0] ALUresult // Resultado de la operación
);

    // Variables para almacenar los resultados de las operaciones
    logic [15:0] add_result, sub_result, lsl_result, neg_result, compare_result;

    // Instanciar los módulos adder y subtractor
    adder u_adder (
        .a(srcA),
        .b(srcB),
        .y(add_result)
    );

    subtractor u_subtractor (
        .a(srcA),
        .b(srcB),
        .y(sub_result)
    );
	 
	 LogicalShiftLeft LogicalShiftLeft_inst (
        .data_in(srcA),
        .shift_amount(srcB),
        .shifted_data(lsl_result)
    );
	 
	 negation negation_inst (
		  .data_in(srcA),
		  .negated_data(neg_result)
	 );
	 
	 comparator comparator_inst (
        .num1(srcA),
        .num2(srcB),
        .result(compare_result)
    );

    // Selección de la operación basada en ALUop
    always_comb begin
        case (ALUop)
            2'b000: ALUresult = sub_result; 					// Resta
            2'b001: ALUresult = add_result; 					// Suma
				2'b010: ALUresult = lsl_result; 					// Desplazamiento hacia la izquierda
				2'b011: ALUresult = neg_result; 					// Negacion
				2'b100: ALUresult = srcA; 		  					// Buffer para la direccion de memoria en donde guardar un dato (str)
				2'b101: ALUresult = compare_result; 		   // srcA=srcB result=0 	|		srcA>srcB result=1 	|		srcA<srcB result=2
            default: ALUresult = 16'hXXXX;  // Manejo de caso inválido
        endcase
    end

endmodule
