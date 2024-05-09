module CPU(
				input logic clk ,
				input logic reset,
				input logic vga_clk,
				input logic VGA_enable,
				output logic [7:0] pixel
				
);

/////////////////////// CABLES, VARIABLES E I/O DE LOS MODULOS /////////////////////////////////////////

logic [15:0] pixelAddress;	// direccion de memoria donde estan los pixeles

logic [15:0] PCaddress_out; // salida del registro PC y entrada al PC adder y la memoria rom
logic [15:0] mux_out_pc; // salida del mux del PC y que entra al registro pc 
logic [15:0] PC_plus1; // salida del sumador del PC (PC + 1)


logic [15:0] jumpAddress; // entrada al mux del PC, es la direccion de un salto

logic [15:0] instruction_fetch; // salida de la memoria rom y entrada al registro pipeline FETCH-DECODE
logic [15:0] instruction_decode; // salida del registro pipeline FETCH-DECODE





/////////// SEÑALES DE CONTROL /////////////////////////////////////////////////////////////////////////

logic ni; // Next Instruction, es al señal de control del mux del PC 







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
        .select(ni), 
        .out(mux_pc)
    );
	 
	ROM ROM_instance(
		.address(PCaddress_out),
		.clock(clk),
		.q(instruction_fetch));
		

///////////// REGISTRO PIPELINE FETCH-DECODE ////
    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_fetch),
        .instruction_out(instruction_decode)
    );
	 


///////////// ETAPA DECODE ////////////////////////////////////////////////////////////////////////////


















///////////// ETAPA EXECUTE ////////////////////////////////////////////////////////////////////////////



///////////// ETAPA MEMORY ////////////////////////////////////////////////////////////////////////////



///////////// ETAPA WRITEBACK ////////////////////////////////////////////////////////////////////////////












////////////////////////////////////////////////////////////////////7











/*

	logic [15:0] instruction_fetch;
   logic [15:0] instruction_decode;
	logic [15:0] alu_pc;
	logic [15:0] mux_pc;
   logic [15:0] address_pc = 16'b0000000000000000;
	
	logic flagN;
	logic flagZ;
	
	logic wbs_decode, wme_decode, mm_decode;
   logic [2:0] ALUop_decode;
   logic wm_decode;
   logic am_decode;
   logic ni_decode;
	logic [15:0] srcA_decode;
	logic [15:0] srcB_decode;
	

	logic [1:0] ri;
	logic wre;
	
	logic [15:0] SignExtImmediate;
	
	logic [15:0] ZeroExtImmediate;
	
	logic [15:0] rd1, rd2, rd3;
   logic [15:0] out_mux4;
	
	logic wbs_execute, wme_execute, mm_execute;
   logic [2:0] ALUop_execute;
   logic wm_execute;
   logic am_execute;
   logic ni_execute;
	logic [15:0] srcA_execute;
	logic [15:0] srcB_execute;
	
	logic [15:0] alu_result_execute;
	logic [15:0] alu_result_execute1;
	logic [15:0] write_Data_execute;
	
	logic wbs_memory, wme_memory, mm_memory;	
	logic [15:0] alu_result_memory;
	logic [15:0] write_Data_memory;
	logic wm_memory;
	logic ni_memory;
	
	logic [15:0] data1_memory;
	logic [15:0] data2_memory;
	logic [15:0] muxResult_memory;
	logic [15:0] readData_memory;
	
	logic wbs_writeback;
	logic [15:0] memData_writeback;
	logic [15:0] alu_result_writeback;
	logic ni_writeback;
	
	logic [15:0] mux_2_writeback_result;
	
	logic [15:0] PCadder_input = 16'b0000000000000000;
	logic [15:0] PCadder_output;
	
	PCadder PCadder_instance (
        .address(PCadder_input),		//cambiar
        .PC(PCadder_output)				//cambiar
    );
	 
	 
	PCregister PCregister_instance(
		.clk(clk),
		.reset(reset),
		.address_in(mux_pc),       
		.address_out(address_pc)
	);
    
	ROM ROM(
		.address(address_pc),
		.clock(clk),
		.q(instruction_fetch)
	);
		
	mux_2 mux_2_fetch(
		.data0(alu_pc),
      .data1(srcB_execute),
      .select(ni_decode), 
      .out(mux_pc) 
   );
	
	ALU ALU_fetch(
      .ALUop(3'b001), 											// Operación ALU de suma
      .srcA(16'b0000000000000001),							// Sumando 1 al la direccion del registro del PC
      .srcB(mux_pc),
      .ALUresult(alu_pc),
      .flagN(flagN),
      .flagZ(flagZ)
    );
	 
    FetchDecode_register FetchDecode_register(
		.clk(clk),
      .instruction_in(instruction_fetch),
      .instruction_out(instruction_decode)
    );
	 
	   
	controlUnit control_unit (
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
     
   signExtend signExtend(
      .Immediate(instruction_decode[7:0]),
      .SignExtImmediate(SignExtImmediate)
   );

   zeroExtend zeroExtend(
      .Immediate(instruction_decode[12:0]),
      .ZeroExtImmediate(ZeroExtImmediate)
   );
     
   regfile regfile(
      .clk(clk),
      .wre(wre),
      .a1(instruction_decode[3:0]),
      .a2(instruction_decode[7:4]),
      .a3(instruction_decode[11:8]),
      .wd3(mux_2_writeback_result),
      .rd1(rd1),
      .rd2(rd2),
      .rd3(rd3)
   );
	 
	mux_4 mux_4(
      .data0(rd2),
      .data1(rd3),
      .data2(SignExtImmediate),
      .data3(ZeroExtImmediate),
      .select(ri),
      .out(out_mux4)
   );

	DecodeExecute_register DecodeExecute_register(
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
	
	
	ALU ALU_memory (
      .ALUop(ALUop_execute),       
      .srcA(srcA_execute),
      .srcB(srcB_execute),
      .ALUresult(alu_result_execute),
      .flagN(FlagN),
      .flagZ(FlagZ)
   );
	
	decoderMemory decoder(
		.data_in(srcB_execute),
		.select(am_execute),
		.data_out_0(alu_result_execute1),
		.data_out_1(write_Data_execute)
   );
	 
   ExecuteMemory_register ExecuteMemory_register(
      .clk(clk),
      .wbs_in(wm_execute),
      .wme_in(wme_execute),
      .mm_in(mm_execute),
		
      .ALUresult_in(alu_result_execute),
      .memData_in(write_Data_execute),
		
      .wm_in(wm_execute),
      .ni_in(ni_execute),
		
      .wbs_out(wbs_memory),
      .wme_out(wme_memory),
      .mm_out(mm_memory),
		
      .ALUresult_out(alu_result_memory),
      .memData_out(write_Data_memory),
		
      .wm_out(wm_memory),
      .ni_out(ni_memory)
   );
		
	decoderMemory decoderMemory(
		.data_in(alu_result_memory),
      .select(mm_memory),
      .data_out_0(data1_memory), 
      .data_out_1(data2_memory)  
   );
	
	mux_2 mux_2_memory (
      .data0(data1_memory),
      .data1(write_Data_memory), 
      .select(wm_memory),
      .out(muxResult_memory)
   );
	

	RAM RAM(
		.address(data1_memory),
		.clock(clk),
		.data(write_Data_memory),
		.wren(wme_memory),
		q(readDAta_memory)
		//.data(write_Data_memory),
		//.rdaddress(data1_memory),
		//.wraddress(data1_memory),
		//.wren(wme_memory),
		//.q(readDAta_memory)
	);	
	

   MemoryWriteback_register MemoryWriteback_register(
      .clk(clk),
      .wbs_in(wbs_memory),
      .memData_in(readDAta_memory),
      .calcData_in(muxResult_memory),
      .ni_in(ni_memory), 
      .wbs_out(wbs_writeback),
      .memData_out(memData_writeback),
      .calcData_out(alu_result_writeback),
      .ni_out(ni_writeback)
   );
	
	
	 mux_2 mux_2_writeback (
      .data0(memData_writeback),
      .data1(alu_result_writeback), 
      .select(wbs_writeback),
      .out(mux_2_writeback_result)
   );
*/

endmodule
