module controlUnit (
    input logic [3:0] opCode,
    output logic wbs,
    output logic wme,
    output logic mm,
    output logic [1:0] ALUop,
    output logic [1:0] ri,
    output logic wre
);

    // Definición de las salidas en función del opCode
    always_comb begin
        case (opCode)
            4'b0000: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b1;
            end
            
            4'b0001: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 2'b01;
                ri = 2'b00;
                wre = 1'b1;
            end
            
            4'b0010: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 2'b10;
                ri = 2'b00;
                wre = 1'b1;
            end
				
				4'b0011: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 2'b11;
                ri = 2'b00;
                wre = 1'b1;
            end
				
				4'b0100: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 2'bxx;
                ri = 2'b11;
                wre = 1'b0;
            end
            
            4'b0101: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 2'bxx;
                ri = 2'b11;
                wre = 1'b0;
            end
            
            4'b0110: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 2'bxx;
                ri = 2'b11;
                wre = 1'b0;
            end
				
				4'b0111: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 2'bxx;
                ri = 2'b11;
                wre = 1'b0;
            end
				
				4'b1000: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 2'bxx;
                ri = 2'b10;
                wre = 1'b1;
					 wm = 1'b1;			/////////////
            end
            
            4'b1001: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b10;
                wre = 1'b1;
            end
            
            4'b1010: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
				
				4'b1011: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
				
				4'b1100: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
            
            4'b1101: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
            
            4'b1110: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
				
				4'b1111: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
            
            default: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 2'b00;
                ri = 2'b00;
                wre = 1'b0;
            end
        endcase
    end

endmodule
