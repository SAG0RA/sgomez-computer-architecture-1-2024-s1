module ExecuteMemory_register_tb;

    // Definición de señales
    logic clk = 0;                 // Señal de reloj inicializada en bajo
    logic wbs_in = 0;              // Entrada wbs_in
    //logic wme_in = 0;              // Entrada wme_in
    logic mm_in = 0;               // Entrada mm_in
    logic [15:0] ALUresult_in = 0; // Entrada ALUresult_in
    logic [15:0] memData_in = 0;   // Entrada memData_in
	 logic wm_in = 0;
	 logic ni_in = 0;
	 
	 logic wce_in = 0;
	 logic wme1_in = 0;
	 logic wme2_in = 0;

    logic wbs_out;                 // Salida wbs_out
    //logic wme_out;                 // Salida wme_out
    logic mm_out;                  // Salida mm_out
    logic [15:0] ALUresult_out;    // Salida ALUresult_out
    logic [15:0] memData_out;      // Salida memData_out
	 logic wm_out;
	 logic ni_out;
	 
	 logic wce_out;
	 logic wme1_out;
	 logic wme2_out;

    // Instanciar el módulo ExecuteMemory_register
    ExecuteMemory_register ExecuteMemory_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        //.wme_in(wme_in),
        .mm_in(mm_in),
        .ALUresult_in(ALUresult_in),
        .memData_in(memData_in),
		  .wm_in(wm_in),
		  .ni_in(ni_in),
		  
		  .wce_in(wce_in),
		  .wme1_in(wme1_in),
		  .wme2_in(wme2_in),
		  
        .wbs_out(wbs_out),
        //.wme_out(wme_out),
        .mm_out(mm_out),
        .ALUresult_out(ALUresult_out),
        .memData_out(memData_out),
		  .wm_out(wm_out),
		  .ni_out(ni_out),
		  
		  .wce_out(wce_out),
		  .wme1_out(wme1_out),
		  .wme2_out(wme2_out)
    );

    // Generar el reloj
    always #10 clk = ~clk;

    // Simular cambios en las entradas del registro
    initial begin
        // Ciclo 1: Asignar valores a las entradas del registro
        wbs_in = 1;
        //wme_in = 0;
        mm_in = 1;
        ALUresult_in = 16'h1234;
        memData_in = 16'hABCD;
		  wm_in = 1;
		  ni_in = 1;

        $display("Entradas: wbs_in=%b, mm_in=%b, ALUresult_in=%h, memData_in=%h, wm_in=%b, am_in=%b, ni_in=%b",
                 wbs_in, mm_in, ALUresult_in, memData_in, wm_in, am_in, ni_in);
        // Esperar un ciclo de reloj
        #20;

        // Ciclo 1: Mostrar las salidas del registro
        $display("Salidas (1 Ciclo despues): wbs_out=%b, mm_out=%b, ALUresult_out=%h, memData_out=%h, wm_out=%b, am_out=%b, ni_out=%b",
                 wbs_out, mm_out, ALUresult_out, memData_out, wm_out, am_out, ni_out);
					  
		  $display("\n -----------------------------------------------------------------------------------------");
		  
		  // Ciclo 2: Asignar otros valores a las entradas del registro
        wbs_in = 0;
        //wme_in = 1;
        mm_in = 0;
        ALUresult_in = 16'h4A81;
        memData_in = 16'h7755;
		  wm_in = 0;
		  ni_in = 0;

        $display("Entradas: wbs_in=%b, wme_in=%b, mm_in=%b, ALUresult_in=%h, memData_in=%h, wm_in=%b, am_in=%b, ni_in=%b",
                 wbs_in, wme_in, mm_in, ALUresult_in, memData_in, wm_in, am_in, ni_in);
        // Esperar un ciclo de reloj
        #20;

        // Ciclo 1: Mostrar las salidas del registro
        $display("Salidas (1 Ciclo despues): wbs_out=%b, wme_out=%b, mm_out=%b, ALUresult_out=%h, memData_out=%h, wm_out=%b, am_out=%b, ni_out=%b",
                 wbs_out, wme_out, mm_out, ALUresult_out, memData_out, wm_out, am_out, ni_out);
	
        // Finalizar la simulación
        $finish;
    end

endmodule
