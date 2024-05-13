module CPU(
				input logic clk ,
				input logic reset,
				input logic vga_clk,
				input logic VGA_enable,
				input logic enable,
				output logic [7:0] pixel
				
);

/////////////////////// CABLES, I/O DE LOS MODULOS Y VARIABLES //////////////////////////////////////////

logic [15:0] pixelAddress;	// direccion de memoria donde estan los pixeles

logic [15:0] PCaddress_out; // salida del registro PC y entrada al PC adder y la memoria rom
logic [15:0] mux_out_pc; // salida del mux del PC y que entra al registro pc 
logic [15:0] PC_plus1; // salida del sumador del PC (PC + 1)

logic [15:0] instruction_fetch; // salida de la memoria rom y entrada al registro pipeline FETCH-DECODE
logic [15:0] instruction_decode; // salida del registro pipeline FETCH-DECODE


logic [15:0] SignExtImmediate;
logic [15:0] ZeroExtImmediate;

logic [15:0] wd3; // dato a escribir en el banco de registros
logic [15:0] rd1, rd2, rd3; // direcciones en el banco de registros
logic [15:0] out_mux4; // salida del mux de 4 entradas

logic [15:0] read_addres_or_data; // salida del decoder y entrada al mux en la etapa execute
logic [15:0] write_Data_execute;	// salida del decoder y entrada al registro pipeline execute-memory
logic [15:0] alu_result;	// resultado de la ALU
logic [15:0] output_alu_mux; 	// salida del mux de la ALU 

logic [15:0] address_coordinates_memory; 
logic [15:0] write_register_data;
logic [15:0] address_pixel_memory;	

logic [15:0] output_memory_mux; 	// salida del mux que está en la etapa de memory

logic [15:0] neverReaded; // salida de la memoria que nunca se lee, se crea porque se debe especificar un parametro


logic wbs_writeback;
logic [15:0] readCoordinate_writeback;
logic [15:0] calcData_writeback;
logic ni_writeback;

logic [15:0] reg_dest_data_decode;	// no se usa
logic [15:0] reg_dest_data_execute;
logic [15:0] reg_dest_data_memory;
logic [3:0] reg_dest_data_writeback;	// entrada 1 del mux del banco de registros (reg file)
logic [15:0] reg_dest_mux_out;	// entrada 0 del mux del banco de registros (reg file)


logic alu_or_address;
logic [15:0] output_execute;

/////////// SEÑALES DE CONTROL /////////////////////////////////////////////////////////////////////////

logic ni; // Next Instruction, es al señal de control del mux del PC   ****  OJO  revisar esta señal ***

logic flagN, flagZ; // Banderas de la ALU para resultados negativos y zero

logic wbs_decode;
logic [1:0] mm_decode;
logic [2:0] ALUop_decode;
logic [1:0] ri;
//logic wre;								//////////////////////////////////////////
logic wre_decode;
logic wm_decode;
logic am_decode;
logic ni_decode;
logic wce_decode;
logic wme1_decode;
logic wme2_decode;

logic alu_mux_decode;		



logic wbs_execute;
logic [1:0] mm_execute;
logic [2:0] ALUop_execute;
logic wre_execute;		///////////////////////////////////////
logic wm_execute;
logic am_execute;
logic ni_execute;	
logic wce_execute;
logic wme1_execute;
logic wme2_execute;	
logic srcA_execute;
logic srcB_execute;
		
logic alu_mux_execute;
		
logic wbs_memory;   
logic mm_memory;
logic alu_result_memory;
logic write_Data_memory;
logic wre_memory;					/////////////////////////
logic wm_memory;
logic ni_memory;	
logic wce_memory; 
logic wme1_memory; 
logic wme2_memory; 


logic reg_dest_decode;
logic reg_dest_execute;
logic reg_dest_memory;
logic reg_dest_writeback;


logic wre_writeback;

////// lOGICA PARA LEER LOS PIXELES. SI VGA_enable = 1 (ES UN SWITCH EN LA FPGA) LEE DE LA MEMORIA /////

	 
	 always_ff @(posedge vga_clk) begin
		if (reset || !VGA_enable) begin
			pixelAddress <= 0;
		end else if (pixelAddress >= 65536) begin
			pixelAddress <= 0;
		end else if (VGA_enable && enable) begin
			if (pixelAddress < 65536) begin
				pixelAddress <= pixelAddress + 1;
			end
		end
	end
	/*
	 always_ff @(posedge clk) begin
		ni_decode <= 1;
	end
	 always_ff @(negedge clk) begin
		ni_decode <= 0;
	end
	*/
		
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
	 
	mux_2 mux_2_instance_fetch (
        .data0(PC_plus1),
        .data1(srcB_execute),  // direccion de salto para las instrucciones J
        .select(ni_decode), // Next Instruction, direccion de salto ó PC + 1
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
	 
	always_comb  begin
		if(ALUop_decode == 3'b100) begin
			rs1_source = instruction_decode[11:8];
			alu_or_address = 1'b0;
		end else begin
			rs1_source = instruction_decode[3:0];
			alu_or_address = 1'b1;
		end
	end

///////////// ETAPA DECODE ////////////////////////////////////////////////////////////////////////////

controlUnit control_unit_instance (
      .opCode(instruction_decode[15:12]),
      .flagN(flagN),
      .flagZ(flagZ),
      .wbs(wbs_decode),
      .mm(mm_decode),
      .ALUop(ALUop_decode),
      .ri(ri),
      .wre(wre_decode),
      .wm(wm_decode),
      .am(am_decode),
      .ni(ni_decode),
		
		.wce(wce_decode),
		.wme1(wme1_decode),
		.wme2(wme2_decode),
		.alu_mux(alu_mux_decode),
		.reg_dest(reg_dest_decode)
   );
     
    signExtend signExtend_instance (
      .Immediate(instruction_decode[7:0]),
      .SignExtImmediate(SignExtImmediate)
   );

   zeroExtend zeroExtend_instance (
      .Immediate(instruction_decode[11:0]),
      .ZeroExtImmediate(ZeroExtImmediate)
   );
	
	mux_2_regfile u_mux_2_regfile (
        .data0(instruction_decode[11:8]),
        .data1(reg_dest_data_writeback),
        .select(reg_dest_writeback),		
        .out(reg_dest_mux_out)		/////////////////////////////////////////////
    );

     
   regfile regfile_instance (
      .clk(clk),
      .wre(wre_writeback),  /// revisar  
      .a1(rs1_source), // instruction_decode[3:0]
      .a2(instruction_decode[7:4]),
      .a3(reg_dest_mux_out),
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
		.alu_mux_in(alu_mux_decode),
		
		.reg_dest_in(reg_dest_decode),
		.reg_dest_data_writeback_in(reg_dest_mux_out),
		
		.wre_in(wre_decode),
		
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
		.alu_mux_out(alu_mux_execute),
		
		.reg_dest_out(reg_dest_execute),
		.reg_dest_data_writeback_out(reg_dest_data_execute),
		
		.wre_out(wre_execute),
		
		.srcA_out(srcA_execute),
		.srcB_out(srcB_execute)
   );







///////////// ETAPA EXECUTE ////////////////////////////////////////////////////////////////////////////

	mux_2 mux_2_instance_alu_or_address (
      .data0(srcA_execute),
      .data1(output_alu_mux), 
      .select(alu_or_address),
      .out(output_execute)
   );

	ALU ALU_instance (
      .ALUop(ALUop_execute),       
      .srcA(srcA_execute),
      .srcB(srcB_execute),
      .ALUresult(alu_result),
      .flagN(flagN),
      .flagZ(flagZ)
   );
	
	decoderMemory decoder_instance (
		.data_in(srcB_execute),
		.select(am_execute),
		.data_out_0(read_addres_or_data),
		.data_out_1(write_Data_execute)
   );
	
	mux_2 u_mux_2 (
        .data0(alu_result),
        .data1(read_addres_or_data),
        .select(alu_mux_execute),		
        .out(output_alu_mux)
    );

	 
///////////// REGISTRO PIPELINE EXECUTE-MEMORY ///////////////////////////////////////////////////////////
 
	 ExecuteMemory_register ExecuteMemory_register_instance (
      .clk(clk),
		
      .wbs_in(wbs_execute),
      .mm_in(mm_execute),
      .ALUresult_in(output_execute), 
      .memData_in(write_Data_execute),
      .wm_in(wm_execute),
      .ni_in(ni_execute),
		
		.wce_in(wce_execute),
		.wme1_in(wme1_execute),
		.wme2_in(wme2_execute),
		
		.reg_dest_in(reg_dest_execute),
		.reg_dest_data_writeback_in(reg_dest_data_execute),
		
		.wre_in(wre_execute),
		
      .wbs_out(wbs_memory),
      .mm_out(mm_memory),
      .ALUresult_out(alu_result_memory),
      .memData_out(write_Data_memory),
      .wm_out(wm_memory),
      .ni_out(ni_memory),
		
		.wce_out(wce_memory),
		.wme1_out(wme1_memory),
		.wme2_out(wme2_memory),
		
		.reg_dest_out(reg_dest_memory),
		.reg_dest_data_writeback_out(reg_dest_data_memory),
		
		.wre_out(wre_memory)
   );
	 
	 
	 

///////////// ETAPA MEMORY ////////////////////////////////////////////////////////////////////////////

decoderMemory_3outs decoderMemory_3outs_instance (
		.data_in(alu_result_memory),
      .select(mm_memory),
      .data_out_0(address_coordinates_memory), 
      .data_out_1(write_register_data),
		.data_out_2(address_pixel_memory)		
   );
	
	mux_2 mux_2_instance_memory (
      .data0(write_register_data),
      .data1(write_Data_memory), 
      .select(wm_memory),
      .out(output_memory_mux)
   );	
	
	RAM_coordenadas ram_coordenadas_instance(
		.address(address_coordinates_memory),
		.clock(clk),
		.data(16'b0),			// Nunca se escribe, solo se lee (se coloca un 0 porque no puede quedar vacio)
		.wren(wce_memory),   // Nunca se escribe, solo se lee = 1'b0
		.q(readCoordinate)
	);	
	
	RAM ram_instance(
		.address_a(address_pixel_memory),	// el procesador indica la direccion en donde escribir
		.address_b(pixelAddress),		// direccion para leer el pixel y mostrarlo en pantalla
		.clock(clk),
		.data_a(16'b0),	//write_Data_memory el procesador indica el dato a escribir
		.data_b(16'b0),					// nunca se escriben datos en este puerto
		.wren_a(wme1_memory),		
		.wren_b(wme2_memory), 
		.q_a(neverReaded),
		.q_b(pixel)
	);

///////////// REGISTRO PIPELINE MEMORY-WRITEBACK ///////////////////////////////////////////////////////////

   MemoryWriteback_register MemoryWriteback_register_instance (
      .clk(clk),
      .wbs_in(wbs_memory),
      .memData_in(readCoordinate),
      .calcData_in(output_memory_mux),
      .ni_in(ni_memory), 
		
		.reg_dest_in(reg_dest_memory),
		.reg_dest_data_writeback_in(reg_dest_data_memory),
		
		.wre_in(wre_memory),
		
      .wbs_out(wbs_writeback),
      .memData_out(readCoordinate_writeback),
      .calcData_out(calcData_writeback),
      .ni_out(ni_writeback),
		
		.reg_dest_out(reg_dest_writeback),
		.reg_dest_data_writeback_out(reg_dest_data_writeback),
		
		.wre_out(wre_writeback)
   );
	

///////////// ETAPA WRITEBACK ////////////////////////////////////////////////////////////////////////////

	mux_2 mux_2_instance_writeback (
      .data0(readCoordinate_writeback),
      .data1(calcData_writeback), 
      .select(wbs_writeback),
      .out(wd3)
   );



endmodule