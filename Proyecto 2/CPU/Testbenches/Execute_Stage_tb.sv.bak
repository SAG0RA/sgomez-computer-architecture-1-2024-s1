module Fetch_Stage_tb;

    logic clk = 0;
    
    logic wre;
    logic [1:0] ri;
    
    logic [15:0] instruction_in;    
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
		  instruction_in = 16'b1000100000000111; // mov rd=8 Imm=7
		  
        // Ciclo 1:
        $display("Inicio del primer ciclo");
        $display("Instruccion que ingresa al registro Fetch: instruction_in = %b", instruction_in);
        $display("------------------------------------------------------------------------------------- \n");
		  
		  // Esperar un ciclo de reloj
        #20;
		  $display("Final del primer ciclo");
		  $display("Instruccion que sale al registro Fetch: instruction_out = %b", instruction_out);
        $display("\n ***** Señales de control (salidas de la unidad de control) ***** \n");
        $display("ri (Register or Immediate): %b", ri);
        $display("wre (Write Register Enable): %b", wre);
        $display("ni-decode (Next Instruction): %b", ni_decode);
		  $display("ni-execute (Next Instruction): %b", ni_execute);
		  
        $display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
        $display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
        $display("mm-Decode (Memory or Mov): %b", mm_decode);
        $display("mm-Execute (Memory or Mov): %b", mm_execute);
        $display("wme-Decode (Write Memory Enable): %b", wme_decode);
        $display("wme-Execute (Write Memory Enable): %b", wme_execute);
        $display("wbs-Decode (WriteBack Source): %b", wbs_decode);
        $display("wbs-Execute (WriteBack Source): %b", wbs_execute);
        
        $display("Salida del mux de 4 entradas: %b", out_mux4);
		  
        
        $display("\n \n \n");
		  
		  /////////////////////////////////////////////////////////////////////////////////////
		  
		  instruction_in = 16'b1000000100000010; // mov rd=1 Imm=2
		  
        // Ciclo 1:
        $display("Inicio del segundo ciclo");
        $display("Instruccion que ingresa al registro Fetch: instruction_in = %b", instruction_in);
        $display("------------------------------------------------------------------------------------- \n");
		  
		  // Esperar un ciclo de reloj
        #20;
		  $display("Final del segundo ciclo");
		  $display("Instruccion que sale al registro Fetch: instruction_out = %b", instruction_out);
        $display("\n ***** Señales de control (salidas de la unidad de control) ***** \n");
        $display("ri (Register or Immediate): %b", ri);
        $display("wre (Write Register Enable): %b", wre);
        $display("ni-decode (Next Instruction): %b", ni_decode);
		  $display("ni-execute (Next Instruction): %b", ni_execute);
		  
        $display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
        $display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
        $display("mm-Decode (Memory or Mov): %b", mm_decode);
        $display("mm-Execute (Memory or Mov): %b", mm_execute);
        $display("wme-Decode (Write Memory Enable): %b", wme_decode);
        $display("wme-Execute (Write Memory Enable): %b", wme_execute);
        $display("wbs-Decode (WriteBack Source): %b", wbs_decode);
        $display("wbs-Execute (WriteBack Source): %b", wbs_execute);
        
        $display("Salida del mux de 4 entradas: %b", out_mux4);
		  
        
        $display("\n \n \n");
		  
		  /////////////////////////////////////////////////////////////////////////////////////
		  
		  instruction_in = 16'b0000001010000001; // sub rd=2 rs1=8 rs2=1
		  
        // Ciclo 1:
        $display("Inicio del tercer ciclo");
        $display("Instruccion que ingresa al registro Fetch: instruction_in = %b", instruction_in);
        $display("------------------------------------------------------------------------------------- \n");
		  
		  // Esperar un ciclo de reloj
        #20;
		  $display("Final del tercer ciclo");
		  $display("Instruccion que sale al registro Fetch: instruction_out = %b", instruction_out);
        $display("\n ***** Señales de control (salidas de la unidad de control) ***** \n");
        $display("ri (Register or Immediate): %b", ri);
        $display("wre (Write Register Enable): %b", wre);
        $display("ni-decode (Next Instruction): %b", ni_decode);
		  $display("ni-execute (Next Instruction): %b", ni_execute);
		  
        $display("ALUop-Decode (Operacion de la ALU): %b", ALUop_decode);
        $display("ALUop-Execute (Operacion de la ALU): %b", ALUop_execute);
        $display("mm-Decode (Memory or Mov): %b", mm_decode);
        $display("mm-Execute (Memory or Mov): %b", mm_execute);
        $display("wme-Decode (Write Memory Enable): %b", wme_decode);
        $display("wme-Execute (Write Memory Enable): %b", wme_execute);
        $display("wbs-Decode (WriteBack Source): %b", wbs_decode);
        $display("wbs-Execute (WriteBack Source): %b", wbs_execute);
        
        $display("Salida del mux de 4 entradas: %b", out_mux4);
		  
        
        $display("\n \n");
        
        
        // Finalizar la simulación
        $finish;
    end

endmodule
