module CPU(
				input logic clk ,
				input logic reset,
				input logic vga_clk,
				input logic VGA_enable,
				output logic [7:0] pixel
				
);

/////////////////////// CABLES, I/O DE LOS MODULOS Y VARIABLES //////////////////////////////////////////

logic [15:0] pixelAddress;	// direccion de memoria donde estan los pixeles

logic [15:0] PCaddress_out; // salida del registro PC y entrada al PC adder y la memoria rom
logic [15:0] mux_out_pc; // salida del mux del PC y que entra al registro pc 
logic [15:0] PC_plus1; // salida del sumador del PC (PC + 1)

logic [15:0] jumpAddress; // entrada al mux del PC, es la direccion de un salto

logic [15:0] instruction_fetch; // salida de la memoria rom y entrada al registro pipeline FETCH-DECODE
logic [15:0] instruction_decode; // salida del registro pipeline FETCH-DECODE


logic [15:0] SignExtImmediate;
logic [15:0] ZeroExtImmediate;

logic [15:0] wd3; // dato a escribir en el banco de registros
logic [15:0] rd1, rd2, rd3; // direcciones en el banco de registros
logic [15:0] out_mux4; // salida del mux de 4 entradas

/////////// SEÑALES DE CONTROL /////////////////////////////////////////////////////////////////////////

logic ni; // Next Instruction, es al señal de control del mux del PC 

logic flagN, flagZ; // Banderas de la ALU para resultados negativos y zero

logic wbs_decode;
logic [1:0] mm_decode;
logic [2:0] ALUop_decode;
logic [1:0] ri;
logic wre;
logic wm_decode;
logic am_decode;
logic ni_decode;
logic wce_decode;
logic wme1_decode;
logic wme2_decode;


logic wbs_execute;
logic [1:0] mm_execute;
logic [2:0] ALUop_execute;
logic wm_execute;
logic am_execute;
logic ni_execute;	
logic wce_execute;
logic wme1_execute;
logic wme2_execute;	
logic srcA_execute;
logic srcB_execute;
		
		
		



////// lOGICA PARA LEER LOS PIXELES. SI VGA_enable = 1 (ES UN SWITCH EN LA FPGA) LEE DE LA MEMORIA /////

    always_ff @(posedge vga_clk) begin
        if (reset || !VGA_enable) begin
            pixelAddress <= 0;
        end else if (pixelAddress >= 65535) begin
            pixelAddress <= 0;
        end else if (VGA_enable) begin
            pixelAddress <= pixelAddress + 1;
        end
    end
    
    always_ff @(posedge vga_clk) begin
        if (!VGA_enable) begin
            pixel = 0;
        end 
    end

///////////// ETAPA FETCH ////////////////////////////////////////////////////////////////////////////

	PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(mux_out_pc),       
        .address_out(PCaddress_out)
   );
	 
	PCadder PCadder_instance (
        .address(PCaddress_out),		//input: salida del registro PC
        .PC(PC_plus1)					//output: la entrada (input) + 1 que será la siguiente instruccion si no se da un salto
    ); 
	 
	mux_2 mux_2_instance (
        .data0(PC_plus1),
        .data1(jumpAddress),
        .select(ni), // Next Instruction, direccion de salto ó PC + 1
        .out(mux_out_pc)
    );
	 
	ROM ROM_instance(
		.address(PCaddress_out),
		.clock(clk),
		.q(instruction_fetch));
		

///////////// REGISTRO PIPELINE FETCH-DECODE ///////////////////////////////////////////////////////////
    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_fetch),
        .instruction_out(instruction_decode)
    );
	 


///////////// ETAPA DECODE ////////////////////////////////////////////////////////////////////////////

controlUnit control_unit_instance (
      .opCode(instruction_decode[15:12]),
      .flagN(flagN),
      .flagZ(flagZ),
      .wbs(wbs_decode),
      .mm(mm_decode),
      .ALUop(ALUop_decode),
      .ri(ri),
      .wre(wre),
      .wm(wm_decode),
      .am(am_decode),
      .ni(ni_decode),
		
		.wce(wce_decode),
		.wme1(wme1_decode),
		.wme2(wme2_decode),
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
	

	
///////////// REGISTRO PIPELINE DECODE-EXECUTE ///////////////////////////////////////////////////////////

	DecodeExecute_register DecodeExecute_register_instance (
		.clk(clk),
      .wbs_in(wbs_decode),
      .mm_in(mm_decode),
      .ALUop_in(ALUop_decode),
      .wm_in(wm_decode),
      .am_in(am_decode),
      .ni_in(ni_decode),
		
		.wce_in(wce_decode),
		.wme1_in(wme1_decode),
		.wme2_in(wme2_decode),
		
		.srcA_in(rd1),
		.srcB_in(out_mux4),
      .wbs_out(wbs_execute),
      .mm_out(mm_execute),
      .ALUop_out(ALUop_execute),
      .wm_out(wm_execute),
      .am_out(am_execute),
      .ni_out(ni_execute),
		
		.wce_out(wce_execute),
		.wme1_out(wme1_execute),
		.wme2_out(wme2_execute),
		
		.srcA_out(srcA_execute),
		.srcB_out(srcB_execute)
   );







///////////// ETAPA EXECUTE ////////////////////////////////////////////////////////////////////////////



///////////// ETAPA MEMORY ////////////////////////////////////////////////////////////////////////////



///////////// ETAPA WRITEBACK ////////////////////////////////////////////////////////////////////////////






















endmodule
