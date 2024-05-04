module Decode_Stage_tb;
	logic clk = 0;
	
	logic [15:0] instruction_fetch;    
   logic [15:0] instruction_decode;
	
	logic wbs_decode, wme_decode, mm_decode;
   logic [2:0] ALUop_decode;
   logic wm_decode;
   logic am_decode;
   logic ni_decode;
	
	logic flagN;
	logic flagZ;
	logic [1:0] ri;
	logic wre;
	
	logic [15:0] SignExtImmediate;
	
	logic [15:0] ZeroExtImmediate;
	
	logic [15:0] wd3 = 16'b0000000000000010;//Simulando Valor de prueba que proviene de writeback
	logic [15:0] rd1, rd2, rd3;
   logic [15:0] out_mux4;
	
	logic wbs_execute, wme_execute, mm_execute;
   logic [2:0] ALUop_execute;
   logic wm_execute;
   logic am_execute;
   logic ni_execute;
	logic [15:0] srcA_execute;
	logic [15:0] srcB_execute;

	 
	FetchDecode_register FetchDecode_register_instance (
      .clk(clk),
      .instruction_in(instruction_fetch),
      .instruction_out(instruction_decode)
   );
    
	controlUnit control_unit_instance (
      .opCode(FetchDecode_register_instance.instruction_out[15:12]),
      .flagN(flagN),
      .flagZ(flagZ),
      .wbs(wbs_decode),
      .wme(wme_decode),
      .mm(mm_decode),
      .ALUop(ALUop_decode),
      .ri(ri),
      .wre(wre),
      .wm(wm_decode),
      .am(am_decode),
      .ni(ni_decode)
   );
     
   signExtend signExtend_instance (
      .Immediate(FetchDecode_register_instance.instruction_out[7:0]),
      .SignExtImmediate(SignExtImmediate)
   );

   zeroExtend zeroExtend_instance (
      .Immediate(FetchDecode_register_instance.instruction_out[12:0]),
      .ZeroExtImmediate(ZeroExtImmediate)
   );
     
   regfile regfile_instance (
      .clk(clk),
      .wre(control_unit_instance.wre),
      .a1(FetchDecode_register_instance.instruction_out[3:0]),
      .a2(FetchDecode_register_instance.instruction_out[7:4]),
      .a3(FetchDecode_register_instance.instruction_out[11:8]),
      .wd3(wd3),
      .rd1(rd1),
      .rd2(rd2),
      .rd3(rd3)
   );
	
	 
	mux_4 mux_4_instance (
      .data0(regfile_instance.rd2),
      .data1(regfile_instance.rd3),
      .data2(signExtend_instance.SignExtImmediate),
      .data3(zeroExtend_instance.ZeroExtImmediate),
      .select(control_unit_instance.ri),
      .out(out_mux4)
   );

	DecodeExecute_register DecodeExecute_register_instance (
		.clk(clk),
      .wbs_in(wbs_decode),
      .wme_in(wme_decode),
      .mm_in(mm_decode),
      .ALUop_in(ALUop_decode),
      .wm_in(wm_decode),
      .am_in(am_decode),
      .ni_in(ni_decode),
		.srcA_in(regfile_instance.rd1),
		.srcB_in(mux_4_instance.out),
      .wbs_out(wbs_execute),
      .wme_out(wme_execute),
      .mm_out(mm_execute),
      .ALUop_out(ALUop_execute),
      .wm_out(wm_execute),
      .am_out(am_execute),
      .ni_out(ni_execute),
		.srcA_out(srcA_execute),
		.srcB_out(srcB_execute)
   );
          
   always #10 clk = ~clk;
	initial begin
		instruction_fetch = 16'b0001000000010010; // add rd=0, rs1=1, rs2=2 Tipo R
		#20;
		// Ciclo 1:
		$display("Inicio del primer ciclo");
      $display("Instruccion que ingresa al registro Fetch: instruction_fetch = %b", FetchDecode_register_instance.instruction_in);
		$display("Final del primer ciclo");
		$display("Instruccion que sale al registro Fetch: instruction_decode = %b", FetchDecode_register_instance.instruction_out);
      $display("------------------------------------------------------------------------------------- \n");
      #20;
      $display("\n ***** Señales de control (entradas de la unidad de control) ***** \n");
		$display("Operation code: %b", FetchDecode_register_instance.instruction_out[15:12]);
      $display("flagN (Negative): %b", flagN);
      $display("flagZ (Zero Extend): %b", flagZ);
		$display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		$display("wme-Decode (Write Memory Enable): %b", wme_decode);
		$display("mm-Decode (Memory or Mov): %b", mm_decode);
		$display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		$display("\n ***** Señales de control (salidas de la unidad de control) ***** \n");
      $display("ri (Register or Immediate): %b", ri);
      $display("wre (Write Register Enable): %b", wre);
		$display("wm-Decode (Write Memory): %b", wm_decode);
		$display("am-Decode (      Memory): %b", am_decode);
		$display("ni-Decode (Next Instruction): %b", ni_decode);
		
		
		$display("------------------------------------------------------------------------------------- \n");
		$display("\n ***** Señales del Banco de Registros ***** \n");
		$display("\n ***** Entradas ***** \n");
		$display("wre (WriteBack enable): %b", wre);
		$display("a1: %b", FetchDecode_register_instance.instruction_out[3:0]);
		$display("a2: %b", FetchDecode_register_instance.instruction_out[7:4]);
		$display("a3: %b", FetchDecode_register_instance.instruction_out[11:8]);
		$display("wd3: %b", wd3);
		$display("\n ***** Salidas ***** \n");
		$display("rd1: %b", rd1);
		$display("rd2: %b", rd2);
		$display("rd3: %b", rd3);
		
		$display("------------------------------------------------------------------------------------- \n");
		$display("\n ***** Señales del registro Decode-Execute (entradas) ***** \n");
		$display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		$display("wme-Decode (Write Memory Enable): %b", wme_decode);
		$display("mm-Decode (Memory or Mov): %b", mm_decode);
		$display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		$display("wm-Decode (Write Memory): %b", wm_decode);
		$display("am-Decode (      Memory): %b", am_decode);
		$display("ni-Decode (Next Instruction): %b", ni_decode);
		$display("\n ***** Señales del registro Decode-Execute (Salidas) ***** \n");
		$display("wbs-Execute (WriteBack Source): %b", wbs_execute);
		$display("wme-Execute (Write Memory Enable): %b", wme_execute);
		$display("mm-Execute (Memory or Mov): %b", mm_execute);
		$display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
		$display("wm-Execute (Write Memory): %b", wm_execute);
		$display("am-Execute (      Memory): %b", am_execute);
		$display("ni-Execute (Next Instruction): %b", ni_execute);
		$display("Dato srcA_out: %b", srcA_execute);
		$display("Dato srcB_out: %b", srcB_execute);
		$display("\n \n \n");
		/////////////////////////////////////////////////////////////////////////////////////
		instruction_fetch = 16'b0100000000001000; // beq Address = 0x8 Tipo J
		// Ciclo 2:
      $display("Inicio del segundo ciclo");
      $display("Instruccion que ingresa al registro Fetch: instruction_fetch = %b", FetchDecode_register_instance.instruction_in);
		$display("Final del primer ciclo");
		$display("Instruccion que sale al registro Fetch: instruction_decode = %b", FetchDecode_register_instance.instruction_out);
      $display("------------------------------------------------------------------------------------- \n");
      #20;
      $display("\n ***** Señales de control (entradas de la unidad de control) ***** \n");
		$display("Operation code: %b", FetchDecode_register_instance.instruction_out[15:12]);
      $display("flagN (Negative): %b", flagN);
      $display("flagZ (Zero Extend): %b", flagZ);
		$display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		$display("wme-Decode (Write Memory Enable): %b", wme_decode);
		$display("mm-Decode (Memory or Mov): %b", mm_decode);
		$display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		$display("\n ***** Señales de control (salidas de la unidad de control) ***** \n");
      $display("ri (Register or Immediate): %b", ri);
      $display("wre (Write Register Enable): %b", wre);
		$display("wm-Decode (Write Memory): %b", wm_decode);
		$display("am-Decode (      Memory): %b", am_decode);
		$display("ni-Decode (Next Instruction): %b", ni_decode);
		$display("------------------------------------------------------------------------------------- \n");
		$display("\n ***** Señales del Banco de Registros ***** \n");
		$display("\n ***** Entradas ***** \n");
		$display("wre (WriteBack enable): %b", wre);
		$display("a1: %b", FetchDecode_register_instance.instruction_out[3:0]);
		$display("a2: %b", FetchDecode_register_instance.instruction_out[7:4]);
		$display("a3: %b", FetchDecode_register_instance.instruction_out[11:8]);
		$display("wd3: %b", wd3);
		$display("\n ***** Salidas ***** \n");
		$display("rd1: %b", rd1);
		$display("rd2: %b", rd2);
		$display("rd3: %b", rd3);
		$display("------------------------------------------------------------------------------------- \n");
		$display("\n ***** Señales del registro Decode-Execute (entradas) ***** \n");
		$display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		$display("wme-Decode (Write Memory Enable): %b", wme_decode);
		$display("mm-Decode (Memory or Mov): %b", mm_decode);
		$display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		$display("wm-Decode (Write Memory): %b", wm_decode);
		$display("am-Decode (      Memory): %b", am_decode);
		$display("ni-Decode (Next Instruction): %b", ni_decode);
		$display("\n ***** Señales del registro Decode-Execute (Salidas) ***** \n");
		$display("wbs-Execute (WriteBack Source): %b", wbs_execute);
		$display("wme-Execute (Write Memory Enable): %b", wme_execute);
		$display("mm-Execute (Memory or Mov): %b", mm_execute);
		$display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
		$display("wm-Execute (Write Memory): %b", wm_execute);
		$display("am-Execute (      Memory): %b", am_execute);
		$display("ni-Execute (Next Instruction): %b", ni_execute);
		$display("Dato srcA_out: %b", srcA_execute);
		$display("Dato srcB_out: %b", srcB_execute);
		$display("\n \n \n");
		/////////////////////////////////////////////////////////////////////////////////////
		
		instruction_fetch = 16'b10000010000000110010; // mov rd=2, Imma=50
		// Ciclo 3:
		$display("Inicio del tercer ciclo");
      $display("Instruccion que ingresa al registro Fetch: instruction_fetch = %b", FetchDecode_register_instance.instruction_in);
		$display("Final del primer ciclo");
		$display("Instruccion que sale al registro Fetch: instruction_decode = %b", FetchDecode_register_instance.instruction_out);
      $display("------------------------------------------------------------------------------------- \n");
      #20;
      $display("\n ***** Señales de control (entradas de la unidad de control) ***** \n");
		$display("Operation code: %b", FetchDecode_register_instance.instruction_out[15:12]);
      $display("flagN (Negative): %b", flagN);
      $display("flagZ (Zero Extend): %b", flagZ);
		$display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		$display("wme-Decode (Write Memory Enable): %b", wme_decode);
		$display("mm-Decode (Memory or Mov): %b", mm_decode);
		$display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		$display("\n ***** Señales de control (salidas de la unidad de control) ***** \n");
      $display("ri (Register or Immediate): %b", ri);
      $display("wre (Write Register Enable): %b", wre);
		$display("wm-Decode (Write Memory): %b", wm_decode);
		$display("am-Decode (      Memory): %b", am_decode);
		$display("ni-Decode (Next Instruction): %b", ni_decode);
		$display("------------------------------------------------------------------------------------- \n");
		$display("\n ***** Señales del Banco de Registros ***** \n");
		$display("\n ***** Entradas ***** \n");
		$display("wre (WriteBack enable): %b", wre);
		$display("a1: %b", FetchDecode_register_instance.instruction_out[3:0]);
		$display("a2: %b", FetchDecode_register_instance.instruction_out[7:4]);
		$display("a3: %b", FetchDecode_register_instance.instruction_out[11:8]);
		$display("wd3: %b", wd3);
		$display("\n ***** Salidas ***** \n");
		$display("rd1: %b", rd1);
		$display("rd2: %b", rd2);
		$display("rd3: %b", rd3);
		$display("------------------------------------------------------------------------------------- \n");
		$display("\n ***** Señales del registro Decode-Execute (entradas) ***** \n");
		$display("wbs-Decode (WriteBack Source): %b", wbs_decode);
		$display("wme-Decode (Write Memory Enable): %b", wme_decode);
		$display("mm-Decode (Memory or Mov): %b", mm_decode);
		$display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
		$display("wm-Decode (Write Memory): %b", wm_decode);
		$display("am-Decode (      Memory): %b", am_decode);
		$display("ni-Decode (Next Instruction): %b", ni_decode);
		$display("\n ***** Señales del registro Decode-Execute (Salidas) ***** \n");
		$display("wbs-Execute (WriteBack Source): %b", wbs_execute);
		$display("wme-Execute (Write Memory Enable): %b", wme_execute);
		$display("mm-Execute (Memory or Mov): %b", mm_execute);
		$display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
		$display("wm-Execute (Write Memory): %b", wm_execute);
		$display("am-Execute (      Memory): %b", am_execute);
		$display("ni-Execute (Next Instruction): %b", ni_execute);
		$display("Dato srcA_out: %b", srcA_execute);
		$display("Dato srcB_out: %b", srcB_execute);
		$display("\n \n \n");
		$finish;
	end
endmodule
