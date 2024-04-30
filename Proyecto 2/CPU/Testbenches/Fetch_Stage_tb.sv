module Fetch_Stage_tb;

	logic clk;
	
	logic wre;
	logic ri;
	
	logic [15:0] instruction_in = 16'b0000001010000001; // sub rd=2 rs1=8 rs2=1      
   logic [15:0] instruction_out;
	
	logic [15:0] SignExtImmediate;
   logic [15:0] ZeroExtImmediate;
	
	logic [15:0] wd3 = 16'b0000000000001111; // guardar un 15 en rd
	logic [15:0] rd1, rd2, rd3;
	logic [15:0] out_mux4;	
	
	logic wbs_decode, wme_decode, mm_decode;
   logic [2:0] ALUop_decode;
	logic wm_decode = 0;
	logic am_decode = 0;
	logic ni_decode = 0;
	
	logic wbs_execute, wme_execute, mm_execute;
   logic [2:0] ALUop_execute;
	logic wm_execute;
	logic am_execute;
	logic ni_execute;
	
	

	FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_in),
        .instruction_out(instruction_out)
    );
	 
	 //////////////////////////////////////////////////////////////////////
	 
	 controlUnit control_inst (
        .opCode(instruction_out[15:12]),
		  .flagN(flagN),
		  .flagZ(flagZ),
        .wbs(wbs),
        .wme(wme),
        .mm(mm),
        .ALUop(ALUop),
        .ri(ri),
        .wre(wre),
		  .wm(wm),
		  .am(am),
		  .ni(ni)
    );
	 
	 signExtend signExtend_instance (
        .Immediate(instruction_out[7:0]),
        .SignExtImmediate(SignExtImmediate)
    );

    zeroExtend zeroExtend_instance (
        .Immediate(instruction_out[12:0]),
        .ZeroExtImmediate(ZeroExtImmediate)
    );
	 
    regfile regfile_instance (
        .clk(clk),
        .wre(wre),
        .a1(instruction_out[3:0]),
        .a2(instruction_out[7:4]),
        .a3(instruction_out[11:8]),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2),
        .rd3(rd3)
    );
	 
	 mux_4 mux_4_instance (
        .data0(rd2),
        .data1(rd3),
        .data2(SignExtImmediate),
        .data3(ZeroExtImmediate),
        .select(ri),
        .out(out_mux4)
    );
	 
	 //////////////////////////////////////////////////////////////////////
	 
	 DecodeExecute_register DecodeExecute_register_instance (
        .clk(clk),
        .wbs_in(wbs_decode),
        .wme_in(wme_decode),
        .mm_in(mm_decode),
        .ALUop_in(ALUop_decode),
		  .wm_in(wm_decode),
		  .am_in(am_decode),
		  .ni_in(ni_decode),
        .wbs_out(wbs_execute),
        .wme_out(wme_execute),
        .mm_out(mm_execute),
        .ALUop_out(ALUop_execute),
		  .wm_out(wm_execute),
		  .am_out(am_execute),
		  .ni_out(ni_execute)
    );
	 
	 
	 
	 // Generar el clock
    always #10 clk = ~clk;

    // Simular cambios en las entradas del registro
    initial begin
        // Ciclo 1:
        $display("Inicio");
        $display("Instruccion que ingresa al registro Fetch: instruction_in = %b", instruction_in);
		  $display("\n -------------------------------------------------------------------------------------");
		  $display("Señales de control (salidas de la unidad de control):");
		  $display("ri (Register or Immediate): %b", ri);
		  $display("wre (Write Register Enable): %b", wre);
		  $display("ni (Next Instruction): %b", ni);
		  $display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		  $display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
		  $display("mm-Decode (Memory or Mov): %b", mm_decode);
		  $display("mm-Execute (Memory or Mov): %b", mm_execute);
		  $display("wme-Decode (Write Memory Enable): %b", wme_decode);
		  $display("wme-Execute (Write Memory Enable): %b", wme_execute);
		  $display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		  $display("wbs-Execute (WriteBack Source): %b", wbs_execute);
		  
		  $display("Salida del mux de 4 entradas: %b", out_mux4);
		  
		  
		  
		  
        // Esperar un ciclo de reloj
        #20;
		  $display("\n \n");
        $display("Fin del ciclo 1");
        $display("Señales de control (salidas de la unidad de control):");
		  $display("ri (Register or Immediate): %b", ri);
		  $display("wre (Write Register Enable): %b", wre);
		  $display("ni (Next Instruction): %b", ni);
		  $display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		  $display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
		  $display("mm-Decode (Memory or Mov): %b", mm_decode);
		  $display("mm-Execute (Memory or Mov): %b", mm_execute);
		  $display("wme-Decode (Write Memory Enable): %b", wme_decode);
		  $display("wme-Execute (Write Memory Enable): %b", wme_execute);
		  $display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		  $display("wbs-Execute (WriteBack Source): %b", wbs_execute);
		  
		  $display("Salida del mux de 4 entradas: %b", out_mux4);
		  
		  #20;
		  $display("\n \n");
        $display("Fin del ciclo 2");
        $display("Señales de control (salidas de la unidad de control):");
		  $display("ri (Register or Immediate): %b", ri);
		  $display("wre (Write Register Enable): %b", wre);
		  $display("ni (Next Instruction): %b", ni);
		  $display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		  $display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
		  $display("mm-Decode (Memory or Mov): %b", mm_decode);
		  $display("mm-Execute (Memory or Mov): %b", mm_execute);
		  $display("wme-Decode (Write Memory Enable): %b", wme_decode);
		  $display("wme-Execute (Write Memory Enable): %b", wme_execute);
		  $display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		  $display("wbs-Execute (WriteBack Source): %b", wbs_execute);
		  
		  $display("Salida del mux de 4 entradas: %b", out_mux4);
        // Finalizar la simulación
        $finish;
    end

endmodule
