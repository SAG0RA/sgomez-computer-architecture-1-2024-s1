module alu #(parameter N_bits = 32) 
(
  input logic [N_bits-1:0] SrcA,
  input logic [N_bits-1:0] SrcB,
  input logic [1:0] ALUControl,
  output logic [N_bits-1:0] ALUResult,
  output [3:0] ALUFlags
);
  
  always_comb begin
    case (ALUControl)
      2'b00: // Suma
        ALUResult = SrcA + SrcB;
      2'b01: // Resta
         ALUResult = SrcA - SrcB;
      2'b10: // AND
        ALUResult = SrcA & SrcB;
      2'b11: // OR
        ALUResult = SrcA | SrcB;
      default: // Opción no válida
        // Configura señales de salida en caso de opcode no válido
        ALUResult = {N_bits{1'b0}};
    endcase
	end
    
	 assign ALUFlags = 4'b0000;
	 
  

endmodule