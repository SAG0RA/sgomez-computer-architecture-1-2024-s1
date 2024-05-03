module Execute_Stage_tb;
	logic clk = 0;
	logic wbs_decode = 0; 
	logic wme_decode = 0;
	logic mm_decode = 0;
   logic [2:0] ALUop_decode;
   logic wm_decode = 0;
   logic am_decode = 0;
   logic ni_decode = 0;
	logic [15:0] srcA_decode;
	logic [15:0] srcB_decode;
	logic wbs_execute, wme_execute, mm_execute;
   logic [2:0] ALUop_execute;
   logic wm_execute;
   logic am_execute;
   logic ni_execute;
	logic [15:0] srcA_execute;
	logic [15:0] srcB_execute;
	logic [15:0] alu_result_execute;
	logic [15:0] write_Data_execute;
	
	
	logic wbs_memory, wme_memory, mm_memory;	
	logic [15:0] alu_result_memory;
	logic [15:0] write_Data_memory;
	logic wm_memory;
	logic ni_memory;
	logic flagN;
	logic flagZ;
	      
   DecodeExecute_register DecodeExecute_register_instance (
		.clk(clk),
      .wbs_in(wbs_decode),
      .wme_in(wme_decode),
      .mm_in(mm_decode),
      .ALUop_in(ALUop_decode),
      .wm_in(wm_decode),
      .am_in(am_decode),
      .ni_in(ni_decode),
		.srcA_in(srcA_decode),
		.srcB_in(srcB_decode),
		
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
	 
	ALU ALU_instance (
      .ALUop(DecodeExecute_register_instance.ALUop_out),       
      .srcA(DecodeExecute_register_instance.srcA_out),
      .srcB(DecodeExecute_register_instance.srcB_out),
      .ALUresult(alu_result_execute),
      .flagN(FlagN),
      .flagZ(FlagZ)
   );
	
	decoderMemory decoder_instance (
		.data_in(DecodeExecute_register_instance.srcB_out),
		.select(DecodeExecute_register_instance.am_out),
		.data_out_0(ALU_instance.ALUresult),
		.data_out_1(write_Data_execute)
   );
	 
   ExecuteMemory_register ExecuteMemory_register_instance (
      .clk(clk),
		
      .wbs_in(DecodeExecute_register_instance.wbs_out),
      .wme_in(DecodeExecute_register_instance.wme_out),
      .mm_in(DecodeExecute_register_instance.mm_out),
		
      .ALUresult_in(ALU_instance.ALUresult),
      .memData_in(write_Data_execute),
		
      .wm_in(DecodeExecute_register_instance.wm_in),
      .ni_in(DecodeExecute_register_instance.ni_in),
		
		
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
      $display("Inicio del primer ciclo");
      // Asigna valores simulados para las entradas del DecodeExecute_register
      ALUop_decode = 3'b001;
		wbs_decode = 1; 
		wme_decode = 1;
		mm_decode = 1;
      wm_decode = 1;
      am_decode = 0;
      ni_decode = 1;
      srcA_decode = 16'b0000000000000010;
      srcB_decode = 16'b0000000000000011;
      // Espera al próximo flanco de bajada del reloj
      #10;  
      $display("Resultados del primer ciclo:");
		$display("Entradas DecodeExecute_register:");
      $display("wbs_decode = %b, wme_decode = %b, mm_decode = %b", wbs_decode, wme_decode, mm_decode);
      $display("ALUop_decode = %b, wm_decode = %b, am_decode = %b, ni_decode = %b", ALUop_decode, wm_decode, am_decode, ni_decode);
      $display("srcA_decode = %h, srcB_decode = %h", srcA_decode, srcB_decode);
		// Mostrar entradas y salidas del ExecuteMemory_register
      $display("Resultados del ExecuteMemory_register:");
      $display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("alu_result_memory = %h, write_Data_memory = %h", alu_result_memory, write_Data_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
        
      // Ciclo 2:
      $display("\n \n \n");
      $display("Inicio del segundo ciclo");
      // Asigna nuevos valores simulados para las entradas del DecodeExecute_register
      ALUop_decode = 3'b010;
		wbs_decode = 0; 
		wme_decode = 0;
		mm_decode = 0;
      wm_decode = 0;
      am_decode = 1;
      ni_decode = 0;
      srcA_decode = 16'b1111000011110000;
      srcB_decode = 16'b0000111100001111;
		// Espera al próximo flanco de bajada del reloj
      #20;
		// Mostrar resultados
      $display("Resultados del segundo ciclo:");
      $display("Entradas DecodeExecute_register:");
      $display("wbs_decode = %b, wme_decode = %b, mm_decode = %b", wbs_decode, wme_decode, mm_decode);
      $display("ALUop_decode = %b, wm_decode = %b, am_decode = %b, ni_decode = %b", ALUop_decode, wm_decode, am_decode, ni_decode);
      $display("srcA_decode = %h, srcB_decode = %h", srcA_decode, srcB_decode);
		// Mostrar entradas y salidas del ExecuteMemory_register
      $display("Resultados del ExecuteMemory_register:");
      $display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("alu_result_memory = %h, write_Data_memory = %h", alu_result_memory, write_Data_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
        
      // Ciclo 3:
      $display("\n \n");
      $display("Inicio del tercer ciclo");
      // Asigna nuevos valores simulados para las entradas del DecodeExecute_register
      ALUop_decode = 3'b011;
		wbs_decode = 1; 
		wme_decode = 1;
		mm_decode = 1;
      wm_decode = 1;
      am_decode = 1;
      ni_decode = 1;
      srcA_decode = 16'b0101010101010101;
      srcB_decode = 16'b1010101010101010;
      
      // Espera al próximo flanco de bajada del reloj
      #20;
       
      // Mostrar resultados
      $display("Resultados del tercer ciclo:");
      $display("Entradas DecodeExecute_register:");
      $display("wbs_decode = %b, wme_decode = %b, mm_decode = %b", wbs_decode, wme_decode, mm_decode);
      $display("ALUop_decode = %b, wm_decode = %b, am_decode = %b, ni_decode = %b", ALUop_decode, wm_decode, am_decode, ni_decode);
      $display("srcA_decode = %h, srcB_decode = %h", srcA_decode, srcB_decode);
      // Mostrar entradas y salidas del ExecuteMemory_register
      $display("Resultados del ExecuteMemory_register:");
      $display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("alu_result_memory = %h, write_Data_memory = %h", alu_result_memory, write_Data_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
      $finish;
    end

    
endmodule