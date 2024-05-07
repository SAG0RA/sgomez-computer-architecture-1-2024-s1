module HazardDetectionUnit (
	input logic [3:0] current_opcode,
   input logic [3:0] previous_opcode,
   input logic [3:0] previous_previous_opcode,
   input logic flagN,
   input logic flagZ,
   output logic stall_current,
   output logic stall_previous
);
	// Lógica para la detección de riesgos basada en los opcodes de las instrucciones y las señales de control
   always_comb begin
		case (current_opcode)
			// Casos que pueden requerir un "stall" en la etapa actual (decode)
         4'b1010: stall_current = 1'b1; // Instrucción "str"
         4'b1100: stall_current = 1'b1; // Otra instrucción (ejemplo)
         // Otros casos para stall_current según sea necesario
         default: stall_current = 1'b0; // No se aplica "stall" por defecto en la etapa actual
		endcase
      case (previous_opcode)
			// Casos que pueden requerir un "stall" en la etapa anterior (fetch)
         4'b1010: stall_previous = 1'b1; // Instrucción "str"
         4'b1100: stall_previous = 1'b1; // Otra instrucción (ejemplo)
			default: stall_previous = 1'b0; // No se aplica "stall" por defecto en la etapa anterior
      endcase
    end
endmodule

