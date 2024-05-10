module Execute_Stage_tb;
	logic clk = 0;
	logic wbs_decode = 0; 
	//logic wme_decode = 0;
	logic [1:0] mm_decode = 0;
   logic [2:0] ALUop_decode = 3'b001;
   logic wm_decode = 0;
   logic am_decode = 0;
   logic ni_decode = 0;
	
	logic wce_decode = 0;
	logic wme1_decode = 0;
	logic wme2_decode = 0;
	logic alu_mux_in_decode = 0;
	
	logic [15:0] srcA_decode = 16'b000000000000000;
	logic [15:0] srcB_decode = 16'b000000000000000;
	
	logic wbs_execute;
	logic [1:0] mm_execute;
   logic [2:0] ALUop_execute;
   logic wm_execute;
   logic am_execute;
   logic ni_execute;
	
	logic wce_execute;
	logic wme1_execute;
	logic wme2_execute;
	logic alu_mux_out_execute;
	
	logic [15:0] srcA_execute;
	logic [15:0] srcB_execute;
	logic [15:0] alu_result_execute;
	logic [15:0] write_Data_execute;
	
	logic wbs_memory, wme_memory, mm_memory;	
	logic [15:0] alu_result_memory;
	logic [15:0] write_Data_memory;
	logic wm_memory;
	logic ni_memory;
	
	//logic wce_memory;
	//logic wme1_memory;
	//logic wme2_memory;
	
	logic flagN;
	logic flagZ;
	
	logic [15:0] output_mux;
			
	logic sel_mux = 1'b0;
			
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
		.alu_mux_in(alu_mux_in_decode),
		
		.srcA_in(srcA_decode),
		.srcB_in(srcB_decode),
      .wbs_out(wbs_execute),
      .mm_out(mm_execute),
      .ALUop_out(ALUop_execute),
      .wm_out(wm_execute),
      .am_out(am_execute),
      .ni_out(ni_execute),
		
		.wce_out(wce_execute),
		.wme1_out(wme1_execute),
		.wme2_out(wme2_execute),
		.alu_mux_out(alu_mux_out_execute),
		
		.srcA_out(srcA_execute),
		.srcB_out(srcB_execute)
   );
	 
	ALU ALU_instance (
      .ALUop(ALUop_execute),       
      .srcA(srcA_execute),
      .srcB(srcB_execute),
      .ALUresult(alu_result_execute),
      .flagN(flagN),
      .flagZ(flagZ)
   );
	
	decoderMemory decoder_instance (
		.data_in(srcB_execute),
		.select(am_execute),
		.data_out_0(read_addres_or_data),  //cambiar el nombre al dato parametro
		.data_out_1(write_Data_execute)
   );
	
	mux_2 u_mux_2 (
        .data0(alu_result_execute),
        .data1(read_addres_or_data),
        .select(sel_mux),
        .out(output_mux)
    );
	 
   ExecuteMemory_register ExecuteMemory_register_instance (
      .clk(clk),
		
      .wbs_in(wbs_execute),
      .wme_in(wme_execute),
      .mm_in(mm_execute),
      .ALUresult_in(output_mux), //cambiar nombre
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
	
	always #10 clk = ~clk;
	
	initial begin
		// Ciclo 1:
      $display("1 Primer ciclo ----------------------------------------------------------");
      // Asigna valores simulados para las entradas del DecodeExecute_register
      ALUop_decode = 3'b001;
		wbs_decode = 1; 
		mm_decode = 1;
      wm_decode = 1;
      am_decode = 0;
      ni_decode = 1;
		
		wce_decode = 1;
		wme1_decode = 1;
		wme2_decode = 1;
		
      srcA_decode = 16'b0000000000000010;
      srcB_decode = 16'b0000000000000011;
		
		$display("\n Entradas a DecodeExecute_register:");
      $display("wbs_decode = %b, wme1_decode = %b, mm_decode = %b", wbs_decode, wme1_decode, mm_decode);
      $display("ALUop_decode = %b, wm_decode = %b, am_decode = %b, ni_decode = %b", ALUop_decode, wm_decode, am_decode, ni_decode);
      $display("srcA_decode = %b, srcB_decode = %b", srcA_decode, srcB_decode);
		
		$display("\n Salidas de DecodeExecute_register:");
      $display("wbs_execute = %b, wme1_execute = %b, mm_execute = %b", wbs_execute, wme1_execute, mm_execute);
      $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);
      $display("srcA_execute = %b, srcB_execute = %b", srcA_execute, srcB_execute);
		
		$display("\n Entradas a la ALU:");
		$display("src A = %b, src B = %b", srcA_execute, srcB_execute);
		
		$display("\n Salida de la ALU:");
		$display("alu_result_execute = %b", alu_result_execute);
		
		
		$display("\n Entrada al decoder:");
		$display("src B = %b", srcB_execute);
		
		
		$display("\n Salidas del decoder:");
		$display("Salida 0 = %b", read_addres_or_data);
		$display("Salida 1 = %b", write_Data_execute);
		
		$display("\n Entradas a ExecuteMemori_register:");
		$display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
      $display("wm_execute = %b, ni_execute = %b", wm_execute, ni_execute);
      $display("memData_in = %b, ALUresult_in = %b", write_Data_execute, read_addres_or_data);
		
		$display("\n Salidas de ExecuteMemori_register:");
		$display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
      $display("memData_out = %b, ALUresult_out = %b", write_Data_memory, alu_result_memory);
		
		$display("\n \n \n");
		
		#20
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Ciclo 2:
      $display("2 Segungo ciclo ----------------------------------------------------------");
      // Asigna valores simulados para las entradas del DecodeExecute_register
      ALUop_decode = 3'b011;
		wbs_decode = 0; 
		mm_decode = 0;
      wm_decode = 1;
      am_decode = 1;
      ni_decode = 1;
		
		wce_decode = 1;
		wme1_decode = 1;
		wme2_decode = 1;
		
      srcA_decode = 16'b0000000001010000;
      srcB_decode = 16'b0000000000000111;
		
		$display("\n Entradas a DecodeExecute_register:");
      $display("wbs_decode = %b, wme1_decode = %b, mm_decode = %b", wbs_decode, wme1_decode, mm_decode);
      $display("ALUop_decode = %b, wm_decode = %b, am_decode = %b, ni_decode = %b", ALUop_decode, wm_decode, am_decode, ni_decode);
      $display("srcA_decode = %b, srcB_decode = %b", srcA_decode, srcB_decode);
		
		$display("\n Salidas de DecodeExecute_register:");
      $display("wbs_execute = %b, wme1_execute = %b, mm_execute = %b", wbs_execute, wme1_execute, mm_execute);
      $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);
      $display("srcA_execute = %b, srcB_execute = %b", srcA_execute, srcB_execute);
		
		$display("\n Entradas a la ALU:");
		$display("src A = %b, src B = %b", srcA_execute, srcB_execute);
		
		$display("\n Salida de la ALU:");
		$display("alu_result_execute = %b", alu_result_execute);
		
		
		$display("\n Entrada al decoder:");
		$display("src B = %b", srcB_execute);
		
		
		$display("\n Salidas del decoder:");
		$display("Salida 0 = %b", read_addres_or_data);
		$display("Salida 1 = %b", write_Data_execute);
		
		$display("\n Entradas a ExecuteMemori_register:");
		$display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
      $display("wm_execute = %b, ni_execute = %b", wm_execute, ni_execute);
      $display("memData_in = %b, ALUresult_in = %b", write_Data_execute, read_addres_or_data);
		
		$display("\n Salidas de ExecuteMemori_register:");
		$display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
      $display("memData_out = %b, ALUresult_out = %b", write_Data_memory, alu_result_memory);
		
		$display("\n \n \n");
		
		#20
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		// Ciclo 3:
      $display("3 tercer ciclo ----------------------------------------------------------");
      // Asigna valores simulados para las entradas del DecodeExecute_register
      ALUop_decode = 3'b100;
		wbs_decode = 1; 
		mm_decode = 1;
      wm_decode = 0;
      am_decode = 0;
      ni_decode = 0;
		
		wce_decode = 1;
		wme1_decode = 1;
		wme2_decode = 1;
		
      srcA_decode = 16'b0000000000000001;
      srcB_decode = 16'b0000000000011111;
		
		$display("\n Entradas a DecodeExecute_register:");
      $display("wbs_decode = %b, wme1_decode = %b, mm_decode = %b", wbs_decode, wme1_decode, mm_decode);
      $display("ALUop_decode = %b, wm_decode = %b, am_decode = %b, ni_decode = %b", ALUop_decode, wm_decode, am_decode, ni_decode);
      $display("srcA_decode = %b, srcB_decode = %b", srcA_decode, srcB_decode);
		
		$display("\n Salidas de DecodeExecute_register:");
      $display("wbs_execute = %b, wme1_execute = %b, mm_execute = %b", wbs_execute, wme1_execute, mm_execute);
      $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);
      $display("srcA_execute = %b, srcB_execute = %b", srcA_execute, srcB_execute);
		
		$display("\n Entradas a la ALU:");
		$display("src A = %b, src B = %b", srcA_execute, srcB_execute);
		
		$display("\n Salida de la ALU:");
		$display("alu_result_execute = %b", alu_result_execute);
		
		
		$display("\n Entrada al decoder:");
		$display("src B = %b", srcB_execute);
		
		
		$display("\n Salidas del decoder:");
		$display("Salida 0 = %b", read_addres_or_data);
		$display("Salida 1 = %b", write_Data_execute);
		
		$display("\n Entradas a ExecuteMemori_register:");
		$display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
      $display("wm_execute = %b, ni_execute = %b", wm_execute, ni_execute);
      $display("memData_in = %b, ALUresult_in = %b", write_Data_execute, read_addres_or_data);
		
		$display("\n Salidas de ExecuteMemori_register:");
		$display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
      $display("memData_out = %b, ALUresult_out = %b", write_Data_memory, alu_result_memory);
		
		$display("\n \n \n");
		
		#20
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
      $finish;
    end

    
endmodule