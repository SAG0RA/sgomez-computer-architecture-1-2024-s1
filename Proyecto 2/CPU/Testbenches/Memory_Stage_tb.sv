`timescale 1ps/1ps

module Memory_Stage_tb;
	 
	logic clk = 0;
	logic wbs_execute = 0; 
	logic wme_execute = 1;
	logic mm_execute = 0;
   logic [2:0] ALUop_execute = 3'b001;
   logic wm_execute = 0;
   logic am_execute = 0;
   logic ni_execute = 1;	
	logic [15:0] alu_result_execute  = 16'b0000000000000010;
	logic [15:0] write_Data_execute  = 16'b0000000000000010;
	
	logic wbs_memory, wme_memory, mm_memory;	
	logic [15:0] alu_result_memory;
	logic [15:0] write_Data_memory;
	logic wm_memory;
	logic ni_memory;
	
	logic [15:0] data1;
	logic [15:0] data2;
	logic [15:0] muxResult;
	logic [15:0] readData;
	
	logic wbs_writeback;
	logic [15:0] memData_writeback;
	logic [15:0] alu_result_writeback;
	logic ni_writeback;
	
   ExecuteMemory_register ExecuteMemory_register_instance (
		.clk(clk),
      .wbs_in(wbs_execute),
      .wme_in(wme_execute),
      .mm_in(mm_execute),
      .ALUresult_in(ALUop_execute),
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
	
	decoderMemory decoderMemory_instance (
		.data_in(ExecuteMemory_register_instance.ALUresult_out),
      .select(ExecuteMemory_register_instance.mm_out),
      .data_out_0(data1), 
      .data_out_1(data2)  
   );
	
	mux_2 mux_2_instance (
      .data0(decoderMemory_instance.data_out_0),
      .data1(ExecuteMemory_register_instance.memData_out), 
      .select(ExecuteMemory_register_instance.wm_out),
      .out(muxResult)
   );
	
	
	RAM ram_instance(.clock(clk),
		.data(ExecuteMemory_register_instance.memData_out),
		.rdaddress(decoderMemory_instance.data_out_0),
		.wraddress(decoderMemory_instance.data_out_0),
		.wren(ExecuteMemory_register_instance.wme_out),
		.q(readDAta)
	);	

   MemoryWriteback_register MemoryWriteback_register_instance (
      .clk(clk),
      .wbs_in(ExecuteMemory_register_instance.wbs_in),
      .memData_in(ram_instance.q),
      .ALUresult_in(mux_2_instance.out),
      .ni_in(ExecuteMemory_register_instance.ni_out), 
      .wbs_out(wbs_writeback),
      .memData_out(memData_writeback),
      .ALUresult_out(alu_result_writeback),
      .ni_out(ni_writeback)
   );

   always #10 clk = ~clk;
	
	initial begin
		// Ciclo 1:
      $display("Inicio del primer ciclo");
      // Asigna valores simulados para las entradas del ExecuteMemory_register
      wbs_execute = 1;
      wme_execute = 0;
      mm_execute = 1;
      ALUop_execute = 3'b010;
      wm_execute = 1;
      am_execute = 0;
      ni_execute = 1;
      alu_result_execute = 16'b1111111100000000;
      write_Data_execute = 16'b0000000011111111;
      // Espera al próximo flanco de bajada del reloj
      #10;
      // Mostrar resultados del primer ciclo
      $display("Resultados del primer ciclo:");
      $display("Entradas ExecuteMemory_register:");
      $display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
      $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);
      $display("alu_result_execute = %h, write_Data_execute = %h", alu_result_execute, write_Data_execute);
      $display("Salidas ExecuteMemory_register:");
      $display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("alu_result_memory = %h, write_Data_memory = %h", alu_result_memory, write_Data_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
		// Mostrar entradas y salidas del MemoryWriteback_register
      $display("\n");
      $display("Resultados del MemoryWriteback_register:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, alu_result_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, alu_result_writeback, ni_writeback);  
      
  
      // Ciclo 2:
      $display("\n \n \n");
      $display("Inicio del segundo ciclo");
      // Asigna nuevos valores simulados para las entradas del ExecuteMemory_register
      wbs_execute = 0;
      wme_execute = 1;
      mm_execute = 0;
      ALUop_execute = 3'b011;
      wm_execute = 0;
      am_execute = 1;
      ni_execute = 0;
      alu_result_execute = 16'b1010101010101010;
      write_Data_execute = 16'b0101010101010101;   
      // Espera al próximo flanco de bajada del reloj
      #20;  
      // Mostrar resultados del segundo ciclo
      $display("Resultados del segundo ciclo:");
      $display("Entradas ExecuteMemory_register:");
      $display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
      $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);
      $display("alu_result_execute = %h, write_Data_execute = %h", alu_result_execute, write_Data_execute); 
		$display("Salidas ExecuteMemory_register:");
		$display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
		$display("alu_result_memory = %h, write_Data_memory = %h", alu_result_memory, write_Data_memory);
		$display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
		// Mostrar entradas y salidas del MemoryWriteback_register
      $display("\n");
      $display("Resultados del MemoryWriteback_register:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, alu_result_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, alu_result_writeback, ni_writeback);  
      
        
      // Ciclo 3:
      $display("\n \n");
      $display("Inicio del tercer ciclo");
      // Asigna nuevos valores simulados para las entradas del ExecuteMemory_register
		wbs_execute = 1;
      wme_execute = 1;
      mm_execute = 1;
      ALUop_execute = 3'b101;
      wm_execute = 1;
      am_execute = 1;
      ni_execute = 1;
      alu_result_execute = 16'b0101010101010101;
      write_Data_execute = 16'b1010101010101010;   
      // Espera al próximo flanco de bajada del reloj
      #20; 
      // Mostrar resultados del tercer ciclo
      $display("Resultados del tercer ciclo:");
      $display("Entradas ExecuteMemory_register:");
      $display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
      $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);
      $display("alu_result_execute = %h, write_Data_execute = %h", alu_result_execute, write_Data_execute);
      $display("Salidas ExecuteMemory_register:");
      $display("wbs_memory = %b, wme_memory = %b, mm_memory = %b", wbs_memory, wme_memory, mm_memory);
      $display("alu_result_memory = %h, write_Data_memory = %h", alu_result_memory, write_Data_memory);
      $display("wm_memory = %b, ni_memory = %b", wm_memory, ni_memory);
      // Mostrar entradas y salidas del MemoryWriteback_register
      $display("\n");
      $display("Resultados del MemoryWriteback_register:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, alu_result_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, alu_result_writeback, ni_writeback);  
      $finish;
    end


endmodule
