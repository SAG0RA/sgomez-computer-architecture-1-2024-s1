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
      .opCode(instruction_decode[15:12]),
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
      .Immediate(instruction_decode[7:0]),
      .SignExtImmediate(SignExtImmediate)
   );

   zeroExtend zeroExtend_instance (
      .Immediate(instruction_decode[11:0]),
      .ZeroExtImmediate(ZeroExtImmediate)
   );
     
   regfile regfile_instance (
      .clk(clk),
      .wre(wre),
      .a1(instruction_decode[3:0]),
      .a2(instruction_decode[7:4]),
      .a3(instruction_decode[11:8]),
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

	DecodeExecute_register DecodeExecute_register_instance (
		.clk(clk),
      .wbs_in(wbs_decode),
      .wme_in(wme_decode),
      .mm_in(mm_decode),
      .ALUop_in(ALUop_decode),
      .wm_in(wm_decode),
      .am_in(am_decode),
      .ni_in(ni_decode),
		.srcA_in(rd1),
		.srcB_in(out_mux4),
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
	
		instruction_fetch = 16'b1000000100000111; // mov rd=1 inmediato=7 Tipo I
		
		$display("\n *** 1 *** \n");
		$display("mov rd=1 inmediato=7 Tipo I \n");
		$display("Instruccion que viene de la memoria de instrucciones = %b", instruction_fetch);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Instruccion que sale del registro FETCH-DECODE = %b", instruction_decode);
		$display("Entradas de la unidad de control ---------------------------------------------------- \n");
		$display("Codigo de operacion = %b", instruction_decode[15:12]);
		$display("flagN: %b", flagN);
      $display("flagZ: %b", flagZ);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas de la unidad de control ----------------------------------------------------- \n");
		$display("wbs: %b", wbs_decode);
		$display("wme: %b", wme_decode);
		$display("mm: %b", mm_decode);
		$display("ALUop: %b", ALUop_decode);
		$display("ri: %b", ri);
		$display("wre: %b", wre);
		$display("wm: %b", wm_decode);
		$display("am: %b", am_decode);
		$display("ni: %b", ni_decode);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Otras partes de la instruccion ------------------------------------------------------ \n");
		$display("RS1: %b", instruction_decode[3:0]);
		$display("RS2: %b", instruction_decode[7:4]);
		$display("RD: %b", instruction_decode[11:8]);
		$display("Inmediato del formato I: %b", instruction_decode[7:0]);
		$display("Extension de signo: %b", SignExtImmediate);
		$display("Inmediato del formato J: %b", instruction_decode[11:0]);
		$display("Extension de zero: %b", ZeroExtImmediate);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Banco de registros ------------------------------------------------------------------ \n");
		$display("WD3: %b", wd3);
		$display("RD1: %b", rd1);
		$display("RD2: %b", rd2);
		$display("RD3: %b", rd3);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salida del mux ---------------------------------------------------------------------- \n");
		$display("out_mux4: %b", out_mux4);
		$display("------------------------------------------------------------------------------------- \n");
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas del registro DECODE-EXECUTE (debe ir 1 ciclo atrasado)\n");
		$display("wbs: %b", wbs_execute);
		$display("wme: %b", wme_execute);
		$display("mm: %b", mm_execute);
		$display("ALUop: %b", ALUop_execute);
		$display("wm: %b", wm_execute);
		$display("am: %b", am_execute);
		$display("ni: %b", ni_execute);
		$display("src A: %b", srcA_execute);
		$display("src B: %b", srcB_execute);
		$display("\n \n \n");
		
		
		#20;
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		instruction_fetch = 16'b1000001000001001; // mov rd=2 inmediato=9 Tipo I
		
		$display("\n *** 2 *** \n");
		$display("mov rd=2 inmediato=9 Tipo I \n");
		$display("Instruccion que viene de la memoria de instrucciones = %b", instruction_fetch);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Instruccion que sale del registro FETCH-DECODE = %b", instruction_decode);
		$display("Entradas de la unidad de control ---------------------------------------------------- \n");
		$display("Codigo de operacion = %b", instruction_decode[15:12]);
		$display("flagN: %b", flagN);
      $display("flagZ: %b", flagZ);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas de la unidad de control ----------------------------------------------------- \n");
		$display("wbs: %b", wbs_decode);
		$display("wme: %b", wme_decode);
		$display("mm: %b", mm_decode);
		$display("ALUop: %b", ALUop_decode);
		$display("ri: %b", ri);
		$display("wre: %b", wre);
		$display("wm: %b", wm_decode);
		$display("am: %b", am_decode);
		$display("ni: %b", ni_decode);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Otras partes de la instruccion ------------------------------------------------------ \n");
		$display("RS1: %b", instruction_decode[3:0]);
		$display("RS2: %b", instruction_decode[7:4]);
		$display("RD: %b", instruction_decode[11:8]);
		$display("Inmediato del formato I: %b", instruction_decode[7:0]);
		$display("Extension de signo: %b", SignExtImmediate);
		$display("Inmediato del formato J: %b", instruction_decode[11:0]);
		$display("Extension de zero: %b", ZeroExtImmediate);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Banco de registros ------------------------------------------------------------------ \n");
		$display("WD3: %b", wd3);
		$display("RD1: %b", rd1);
		$display("RD2: %b", rd2);
		$display("RD3: %b", rd3);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salida del mux ---------------------------------------------------------------------- \n");
		$display("out_mux4: %b", out_mux4);
		$display("------------------------------------------------------------------------------------- \n");
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas del registro DECODE-EXECUTE (debe ir 1 ciclo atrasado)\n");
		$display("wbs: %b", wbs_execute);
		$display("wme: %b", wme_execute);
		$display("mm: %b", mm_execute);
		$display("ALUop: %b", ALUop_execute);
		$display("wm: %b", wm_execute);
		$display("am: %b", am_execute);
		$display("ni: %b", ni_execute);
		$display("src A: %b", srcA_execute);
		$display("src B: %b", srcB_execute);
		$display("\n \n \n");
		
		
		#20;
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		instruction_fetch = 16'b0001000000010010; // add rd=0, rs1=1, rs2=2 Tipo R
		
		$display("\n *** 3 *** \n");
		$display("add rd=0, rs1=1, rs2=2 Tipo R \n");
		$display("Instruccion que viene de la memoria de instrucciones = %b", instruction_fetch);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Instruccion que sale del registro FETCH-DECODE = %b", instruction_decode);
		$display("Entradas de la unidad de control ---------------------------------------------------- \n");
		$display("Codigo de operacion = %b", instruction_decode[15:12]);
		$display("flagN: %b", flagN);
      $display("flagZ: %b", flagZ);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas de la unidad de control ----------------------------------------------------- \n");
		$display("wbs: %b", wbs_decode);
		$display("wme: %b", wme_decode);
		$display("mm: %b", mm_decode);
		$display("ALUop: %b", ALUop_decode);
		$display("ri: %b", ri);
		$display("wre: %b", wre);
		$display("wm: %b", wm_decode);
		$display("am: %b", am_decode);
		$display("ni: %b", ni_decode);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Otras partes de la instruccion ------------------------------------------------------ \n");
		$display("RS1: %b", instruction_decode[3:0]);
		$display("RS2: %b", instruction_decode[7:4]);
		$display("RD: %b", instruction_decode[11:8]);
		$display("Inmediato del formato I: %b", instruction_decode[7:0]);
		$display("Extension de signo: %b", SignExtImmediate);
		$display("Inmediato del formato J: %b", instruction_decode[11:0]);
		$display("Extension de zero: %b", ZeroExtImmediate);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Banco de registros ------------------------------------------------------------------ \n");
		$display("WD3: %b", wd3);
		$display("RD1: %b", rd1);
		$display("RD2: %b", rd2);
		$display("RD3: %b", rd3);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salida del mux ---------------------------------------------------------------------- \n");
		$display("out_mux4: %b", out_mux4);
		$display("------------------------------------------------------------------------------------- \n");
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas del registro DECODE-EXECUTE (debe ir 1 ciclo atrasado)\n");
		$display("wbs: %b", wbs_execute);
		$display("wme: %b", wme_execute);
		$display("mm: %b", mm_execute);
		$display("ALUop: %b", ALUop_execute);
		$display("wm: %b", wm_execute);
		$display("am: %b", am_execute);
		$display("ni: %b", ni_execute);
		$display("src A: %b", srcA_execute);
		$display("src B: %b", srcB_execute);
		$display("\n \n \n");
		
		
		#20;
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		instruction_fetch = 16'b0101000000000101; // bgt address=5 Tipo J
		
		$display("\n *** 4 *** \n");
		$display("bgt address=5 Tipo J \n");
		$display("Instruccion que viene de la memoria de instrucciones = %b", instruction_fetch);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Instruccion que sale del registro FETCH-DECODE = %b", instruction_decode);
		$display("Entradas de la unidad de control ---------------------------------------------------- \n");
		$display("Codigo de operacion = %b", instruction_decode[15:12]);
		$display("flagN: %b", flagN);
      $display("flagZ: %b", flagZ);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas de la unidad de control ----------------------------------------------------- \n");
		$display("wbs: %b", wbs_decode);
		$display("wme: %b", wme_decode);
		$display("mm: %b", mm_decode);
		$display("ALUop: %b", ALUop_decode);
		$display("ri: %b", ri);
		$display("wre: %b", wre);
		$display("wm: %b", wm_decode);
		$display("am: %b", am_decode);
		$display("ni: %b", ni_decode);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Otras partes de la instruccion ------------------------------------------------------ \n");
		$display("RS1: %b", instruction_decode[3:0]);
		$display("RS2: %b", instruction_decode[7:4]);
		$display("RD: %b", instruction_decode[11:8]);
		$display("Inmediato del formato I: %b", instruction_decode[7:0]);
		$display("Extension de signo: %b", SignExtImmediate);
		$display("Inmediato del formato J: %b", instruction_decode[11:0]);
		$display("Extension de zero: %b", ZeroExtImmediate);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Banco de registros ------------------------------------------------------------------ \n");
		$display("WD3: %b", wd3);
		$display("RD1: %b", rd1);
		$display("RD2: %b", rd2);
		$display("RD3: %b", rd3);
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salida del mux ---------------------------------------------------------------------- \n");
		$display("out_mux4: %b", out_mux4);
		$display("------------------------------------------------------------------------------------- \n");
		$display("------------------------------------------------------------------------------------- \n");
		$display("Salidas del registro DECODE-EXECUTE (debe ir 1 ciclo atrasado)\n");
		$display("wbs: %b", wbs_execute);
		$display("wme: %b", wme_execute);
		$display("mm: %b", mm_execute);
		$display("ALUop: %b", ALUop_execute);
		$display("wm: %b", wm_execute);
		$display("am: %b", am_execute);
		$display("ni: %b", ni_execute);
		$display("src A: %b", srcA_execute);
		$display("src B: %b", srcB_execute);
		$display("\n \n \n");
		
		
		#20;
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		$finish;
	end
endmodule
