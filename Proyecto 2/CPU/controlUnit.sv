module controlUnit (
    input logic [3:0] opCode,
	 input logic flagN,	// negative result flagN = 1
	 input logic flagZ,	// zero result flagZ = 1
    output logic wbs,	// writeback source
    output logic [1:0] mm,	// memory or mov
    output logic [2:0] ALUop,
    output logic [1:0] ri,	// register or immediate
    output logic wre,	// write register enable
	 output logic wm,	// write or mov
	 output logic am,	// address or mov
	 output logic ni,	// next instruction
	 output logic wce,	// write coordinates enable
	 output logic wme1,	// write memory enable 1 (pixels memory) for CPU
	 output logic wme2,	// write memory enable 2 (pixels memory) for VGA
	 output logic alu_mux,	// señal para seleccionar 1 de las 2 entradas del mux de la ALU
	 output logic reg_dest	// señal de control para el registro destino (rd) en la etapa writeback
);

    // Definición de las salidas en función del opCode
    always_comb begin
        case (opCode)
		  
				// sub
            4'b0000: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b1;

					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
            
				// add
            4'b0001: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'b001;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
            
				// lsl
            4'b0010: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'b010;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
				
				// neg
				4'b0011: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'b011;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
				
				// beq
				4'b0100: begin
                wbs = 1'bx;
                mm = 2'bxx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'bx;
            end
            
				// bgt
            4'b0101: begin
                wbs = 1'bx;
                mm = 2'bxx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'bx;
            end
            
				// blt
            4'b0110: begin
                wbs = 1'bx;
                mm = 2'bxx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'bx;
            end
				
				// b
				4'b0111: begin
                wbs = 1'bx;
                mm = 2'bxx;
                ALUop = 3'bxxx;
                ri = 2'b11;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'bx;
            end
				
				// movi
				4'b1000: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'bxxx;
                ri = 2'b10;
                wre = 1'b1;
					 wm = 1'b0;			
					 am = 1'b1;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b1;
					 reg_dest = 1'b1;
            end
            
				// ldr
            4'b1001: begin
                wbs = 1'b0;
                mm = 2'b00;
                ALUop = 3'b100;
                ri = 2'b10;
                wre = 1'b1;
					 wm = 1'b1;
					 am = 1'b0;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
            
				// str
            4'b1010: begin
                wbs = 1'bx;
                mm = 2'b10;
                ALUop = 3'b100;
                ri = 2'b10;
                wre = 1'b1;
					 wm = 1'bx;
					 am = 1'b1;
					 ni = 1'b1;
					 
					 wce = 1'b0;
					 wme1 = 1'b1;
					 wme2 = 1'b0;
					 alu_mux =1'b1;
					 reg_dest = 1'b0;
            end
				
				// cmp
				4'b1011: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'b101;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
				
				// movr
				4'b1100: begin
                wbs = 1'b1;
                mm = 2'b01;
                ALUop = 3'b011;
                ri = 2'b00;
                wre = 1'b1;
					 wm = 1'b0;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'b0;
					 reg_dest = 1'b0;
            end
            
				////////////////////// NO HA SIDO ASIGNADO //////////////////////
				
            4'b1101: begin
                wbs = 1'b0;
                mm = 2'b00;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'b0;
            end
            
            4'b1110: begin
                wbs = 1'b0;
                mm = 2'b00;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'b0;
            end
				
				4'b1111: begin
                wbs = 1'bx;
                mm = 2'bxx;
                ALUop = 3'bxxx;
                ri = 2'bxx;
                wre = 1'bx;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b1;
					 
					 wce = 1'bx;
					 wme1 = 1'bx;
					 wme2 = 1'bx;
					 alu_mux =1'bx;
					 reg_dest = 1'bx;
            end
            
            default: begin
                wbs = 1'b0;
                mm = 2'b00;
                ALUop = 3'b000;
                ri = 2'b00;
                wre = 1'b0;
					 wm = 1'bx;
					 am = 1'bx;
					 ni = 1'b0;
					 
					 wce = 1'b0;
					 wme1 = 1'b0;
					 wme2 = 1'b0;
					 alu_mux =1'bx;
					 reg_dest = 1'b0;
            end
        endcase
    end

endmodule
