module Fetch_Stage_tb;

	logic clk;
	
	logic wre;
	logic ri;
	
	logic [15:0] instruction_in = 16'b0000000000000000;          
   logic [15:0] instruction_out;
	
	logic [15:0] SignExtImmediate;
   logic [15:0] ZeroExtImmediate;
	
	logic [15:0] wd3 = 16'b0000000000000000;
	logic [15:0] rd1, rd2, rd3;
	logic [15:0] out_mux4;	
	
	logic wbs_decode, wme_decode, mm_decode;
   logic [1:0] ALUop_decode;
	logic wm_decode = 0;
	logic am_decode = 0;
	logic ni_decode = 0;
	
	logic wbs_execute, wme_execute, mm_execute;
   logic [1:0] ALUop_execute;
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
        $display("Inicio del ciclo 1");
        $display("Instrucción en Fetch Stage: instruction_in = %b", instruction_in);

        // Esperar un ciclo de reloj
        #20;

        $display("Fin del ciclo 1");
        $display("Salidas después del ciclo 1:");
        $display("SignExtImmediate: %b", SignExtImmediate);
        $display("ZeroExtImmediate: %b", ZeroExtImmediate);
        $display("wd3: %b", wd3);
        $display("rd1: %b", rd1);
        $display("rd2: %b", rd2);
        $display("rd3: %b", rd3);
        $display("out_mux4: %b", out_mux4);
        $display("Control Unit Outputs:");
        $display("wbs: %b, wme: %b, mm: %b, ALUop: %b, ri: %b, wre: %b, wm: %b, am: %b, ni: %b", wbs, wme, mm, ALUop, ri, wre, wm, am, ni);
        $display("FlagN: %b, FlagZ: %b", flagN, flagZ);

        // Finalizar la simulación
        $finish;
    end

endmodule
