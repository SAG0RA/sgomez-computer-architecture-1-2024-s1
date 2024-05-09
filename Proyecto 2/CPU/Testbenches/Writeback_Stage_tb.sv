module WriteBack_Stage_tb;
	logic clk = 0;
	logic wbs_memory = 0; 
	logic [15:0] calcData_memory = 16'b0000000000000010;
	logic [15:0] write_Data_memory = 16'b0000000000000000;
	logic ni_memory = 0;
	logic wbs_writeback;
	logic [15:0] memData_writeback;
	logic [15:0] calcData_writeback;
	logic ni_writeback;
	logic [15:0] srcB;
	
   
   MemoryWriteback_register MemoryWriteback_register_instance (
		.clk(clk),
      .wbs_in(wbs_memory),
      .memData_in(write_Data_memory),
      .calcData_in(calcData_memory),
      .ni_in(ni_memory), 
		
      .wbs_out(wbs_writeback),
      .memData_out(memData_writeback),
      .calcData_out(calcData_writeback),
      .ni_out(ni_writeback)
   );
	 
   mux_2 mux_2_instance (
      .data0(MemoryWriteback_register_instance.memData_in),
      .data1(MemoryWriteback_register_instance.ALUresult_in), 
      .select(MemoryWriteback_register_instance.wbs_out),
      .out(srcB)
   );
   always #10 clk = ~clk;
	initial begin
		// Ciclo 1:
      $display("Inicio del primer ciclo");
      // Asigna valores simulados para las entradas del MemoryWriteback_register
      wbs_memory = 1;
      calcData_memory = 16'b1111111100000000;
      write_Data_memory = 16'b0000000011111111;
      ni_memory = 1;
      
      // Espera al próximo flanco de bajada del reloj
      #10;
        
      // Mostrar resultados del primer ciclo
      $display("Resultados del primer ciclo:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_memory = %b, alu_result_memory = %h, write_Data_memory = %h, ni_memory = %b", wbs_memory, alu_result_memory, write_Data_memory, ni_memory);
      $display("Salidas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, calcData_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, calcData_writeback, ni_writeback);
      $display("Valor de srcB = %h", srcB);
      
      // Ciclo 2:
      $display("\n \n \n");
      $display("Inicio del segundo ciclo");
      // Asigna nuevos valores simulados para las entradas del MemoryWriteback_register
      wbs_memory = 0;
      calcData_memory = 16'b1010101010101010;
      write_Data_memory = 16'b0101010101010101;
      ni_memory = 0;
       
      // Espera al próximo flanco de bajada del reloj
      #20;
      
      // Mostrar resultados del segundo ciclo
      $display("Resultados del segundo ciclo:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_memory = %b, alu_result_memory = %h, write_Data_memory = %h, ni_memory = %b", wbs_memory, alu_result_memory, write_Data_memory, ni_memory);
      $display("Salidas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, calcData_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, calcData_writeback, ni_writeback);
      $display("Valor de srcB = %h", srcB);
      
      // Ciclo 3:
      $display("\n \n");
      $display("Inicio del tercer ciclo");
      // Asigna nuevos valores simulados para las entradas del MemoryWriteback_register
      wbs_memory = 1;
      calcData_memory = 16'b0101010101010101;
      write_Data_memory = 16'b1010101010101010;
      ni_memory = 1;
       
      // Espera al próximo flanco de bajada del reloj
      #20;
       
      // Mostrar resultados del tercer ciclo
      $display("Resultados del tercer ciclo:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_memory = %b, alu_result_memory = %h, write_Data_memory = %h, ni_memory = %b", wbs_memory, alu_result_memory, write_Data_memory, ni_memory);
      $display("Salidas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, calcData_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, calcData_writeback, ni_writeback);
      $display("Valor de srcB = %h", srcB);
      $finish;
    end
endmodule
