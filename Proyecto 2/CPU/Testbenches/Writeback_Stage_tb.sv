module WriteBack_Stage_tb;
	logic clk = 0;
	logic wbs_memory;
	logic ni_memory;	
	logic [15:0] alu_result_memory;
	logic [15:0] write_Data_memory;
	logic wbs_writeback;
	logic ni_writeback;
	logic [15:0] memData_writeback;
	logic [15:0] alu_result_writeback;
	logic [15:0] srcB;
	
   
   MemoryWriteback_register MemoryWriteback_register_instance (
		.clk(clk),
      .wbs_in(wbs_memory),
      .memData_in(write_Data_memory),
      .ALUresult_in(alu_result_memory),
      .ni_in(ni_memory), 
		
      .wbs_out(wbs_writeback),
      .memData_out(memData_writeback),
      .ALUresult_out(alu_result_writeback),
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
		$display("--------------------------------INSTRUCCION str rd=14, Imma=3506 Tipo I--------------------------------\n");
		// Ciclo 1:
      $display("Inicio del primer ciclo");
      wbs_memory = 1;
      alu_result_memory = 16'b0000000000001110;
      write_Data_memory = 16'b0000110110110010;
      ni_memory = 1;
      #20;
      $display("Resultados del primer ciclo:");
      $display("Entradas MemoryWriteback_register:");
      $display("wbs_memory = %b, alu_result_memory = %h, write_Data_memory = %h, ni_memory = %b", wbs_memory, alu_result_memory, write_Data_memory, ni_memory);
      $display("Salidas MemoryWriteback_register:");
      $display("wbs_writeback = %b, memData_writeback = %h, alu_result_writeback = %h, ni_writeback = %b", wbs_writeback, memData_writeback, alu_result_writeback, ni_writeback);
      $display("Valor de srcB = %h", srcB);
      $display("\n \n \n");
		$display("----------------------------------------------------------------\n");
      $finish;
    end
endmodule
