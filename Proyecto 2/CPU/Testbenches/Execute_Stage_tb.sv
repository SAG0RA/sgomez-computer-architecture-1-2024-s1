module Execute_Stage_tb;

    logic clk = 0;

    logic wbs_decode, wme_decode, mm_decode;
    logic [2:0] ALUop_decode = 3'b001;
    logic wm_decode = 0;
    logic am_decode = 0;
    logic ni_decode = 0;
    logic wbs_execute = 0;
	 logic wme_execute = 0;
	 logic mm_execute = 0;
    logic [2:0] ALUop_execute;
    logic wm_execute;
    logic am_execute;
    logic ni_execute;
	 
	 
	 logic [15:0] srcA = 16'b0000000000000000;
	 logic [15:0] srcB = 16'b0000000000000001;
    logic [15:0] y;
	 logic [15:0] alu_result_memory;
	 logic [15:0] memData_out;
	 logic wm_out;
	 logic ni_out;
	      
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
	 
	 //Corregir ALU: Agregar Correctamente las fuentes obtenidas y senales del registro DecodeExecute_register
	 ALU ALU_instance (
        .ALUop(DecodeExecute_register_instance.ALUop_out),       
        .srcA(srcA),
        .srcB(srcB),
        .ALUresult(y),
        .flagN(),
        .flagZ()
    );
	 //Corregir MUX: valor de data1 CREO QUE SE OCUPA DECODER DE 4 
	 mux_2 mux_2_instance (
        .data0(y),
        .data1(16'b0),
        .select(DecodeExecute_register_instance.am_out), 
        .out(srcB) 
    );
	 
    ExecuteMemory_register ExecuteMemory_register_instance (
        .clk(clk),
        .wbs_in(DecodeExecute_register_instance.wbs_out),
        .wme_in(DecodeExecute_register_instance.wme_out),
        .mm_in(DecodeExecute_register_instance.mm_out),
        .ALUresult_in(ALU_instance.ALUresult),
        .memData_in(y),//nose cual representa en el diagrama puse uno random
        .wm_in(DecodeExecute_register_instance.wm_in),
        .ni_in(DecodeExecute_register_instance.ni_in),
        .wbs_out(wbs_out),
        .wme_out(wme_out),
        .mm_out(mm_out),
        .ALUresult_out(alu_result_memory),
        .memData_out(memData_out),//nose cual representa en el diagrama 
        .wm_out(wm_out),
        .ni_out(ni_out)
    );
	 // Generar el clock
    always #10 clk = ~clk;

	   // Correr la simulación
    initial begin
        // Ciclo 1:
        $display("Inicio del primer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;

        // Mostrar resultados
        $display("Resultado de la primera prueba:");
        $display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
        $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);

        // Ciclo 2:
        $display("\n \n \n");
        $display("Inicio del segundo ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;

        // Mostrar resultados
        $display("Resultado de la segunda prueba:");
        $display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
        $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);

        // Ciclo 3:
        $display("\n \n");
        $display("Inicio del tercer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;

        // Mostrar resultados
        $display("Resultado de la tercera prueba:");
        $display("wbs_execute = %b, wme_execute = %b, mm_execute = %b", wbs_execute, wme_execute, mm_execute);
        $display("ALUop_execute = %b, wm_execute = %b, am_execute = %b, ni_execute = %b", ALUop_execute, wm_execute, am_execute, ni_execute);

        // Finalizar la simulación
        $finish;
    end

    
endmodule