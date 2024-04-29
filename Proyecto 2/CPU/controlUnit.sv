module controlUnit (
    input logic [3:0] opCode,
	 input logic flagN,
	 input logic flagZ,
    output logic wbs,
    output logic wme,
    output logic mm,
    output logic [2:0] ALUop,
    output logic [1:0] ri,
    output logic wre,
	 output logic wm,
	 output logic am,
	 output logic ni
);

    // Definición de las salidas en función del opCode
    always_comb begin
        case (opCode)
		  
				// sub
            4'b0000: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b0;
            end
            
				// add
            4'b0001: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 3'b001;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b0;
            end
            
				// lsl
            4'b0010: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 3'b010;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b0;
            end
				
				// neg
				4'b0011: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 3'b011;
                ri = 2'bxx;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b0;
            end
				
				// beq
				4'b0100: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = (flagZ == 1) ? 1'b1 : 1'b0;
            end
            
				// bgt
            4'b0101: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = (flagN == 0) ? 1'b1 : 1'b0;
            end
            
				// blt
            4'b0110: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = (flagN == 1) ? 1'b1 : 1'b0;
            end
				
				// b
				4'b0111: begin
                wbs = 1'bx;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
            end
				
				// mov
				4'b1000: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'bx;
                ALUop = 3'bxxx;
                ri = 2'b10;
                wre = 1'b1;
					 wm = 1'b1;			/////////////
					 am = 1'b1;
					 ni = 1'b0;
            end
            
				// ldr
            4'b1001: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 3'bxxx;
                ri = 2'b10;
                wre = 1'b1;
					 wm = 1'bx;
					 am = 1'b0;
					 ni = 1'b0;
            end
            
				// str
            4'b1010: begin
                wbs = 1'bx;
                wme = 1'b1;
                mm = 1'b0;
                ALUop = 3'b100;
                ri = 2'b10;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'b1;
					 ni = 1'b0;
            end
				
				// cmp
				4'b1011: begin
                wbs = 1'b1;
                wme = 1'b0;
                mm = 1'b1;
                ALUop = 3'b101;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b0;
            end
				
				////////////////////// NO HA SIDO ASIGNADO //////////////////////
				4'b1100: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b0;
            end
            
            4'b1101: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b0;
            end
            
            4'b1110: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b0;
            end
				
				4'b1111: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b0;
            end
            
            default: begin
                wbs = 1'b0;
                wme = 1'b0;
                mm = 1'b0;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b0;
            end
        endcase
    end

endmodule
