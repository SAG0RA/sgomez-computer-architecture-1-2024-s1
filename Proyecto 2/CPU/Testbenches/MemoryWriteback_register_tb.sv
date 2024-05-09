module MemoryWriteback_register_tb;

    // Definición de señales
    logic clk = 0;                 // Señal de reloj inicializada en bajo
    logic wbs_in = 0;              // Entrada wbs_in
    logic [15:0] memData_in = 16'h0000;  // Entrada memData_in
    logic [15:0] calcData_in = 16'hFFFF; // Entrada ALUresult_in
	 logic ni_in = 0;
	 
    logic wbs_out;                 // Salida wbs_out
    logic [15:0] memData_out;      // Salida memData_out
    logic [15:0] calcData_out;    // Salida ALUresult_out
	 logic ni_out;

    // Instanciar el módulo MemoryWriteback_register
    MemoryWriteback_register MemoryWriteback_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        .memData_in(memData_in),
        .calcData_in(calcData_in),
		  .ni_in(ni_in),
        .wbs_out(wbs_out),
        .memData_out(memData_out),
        .calcData_out(calcData_out),
		  .ni_out(ni_out)
    );

    // Generar el reloj
    always #10 clk = ~clk;  // Periodo de 10 unidades de tiempo

    // Simular cambios en las entradas del registro
    initial begin
        // Ciclo 1: Asignar valores a las entradas del registro
        wbs_in = 1;
        memData_in = 16'h1234;
        calcData_in = 16'hABCD;
		  ni_in = 1;

		  $display("Entradas: wbs_in=%b, memData_in=%h, CalcData_in=%h, ni_in=%b", wbs_in, memData_in, calcData_in, ni_in);
		  
        #20; // Esperar un tiempo
        
        // Ciclo 1: Mostrar las salidas del registro
        $display("Ciclo 1:");
        $display("Salidas: wbs_out=%b, memData_out=%h, CalcData_out=%h, ni_out=%b", wbs_out, memData_out, calcData_out, ni_out);
        $display("\n ---------------------------------------------");

        // Ciclo 2: Asignar nuevos valores a las entradas del registro
        wbs_in = 0;
        memData_in = 16'h5678;
        calcData_in = 16'h9876;
		  ni_in = 0;

		  $display("Entradas: wbs_in=%b, memData_in=%h, CalcData_in=%h, ni_in=%b", wbs_in, memData_in, calcData_in, ni_in);
		  
        #20; // Esperar un tiempo
        
        // Ciclo 2: Mostrar las salidas del registro
        $display("Ciclo 2:");
        $display("Salidas: wbs_out=%b, memData_out=%h, CalcData_out=%h, ni_out=%b", wbs_out, memData_out, calcData_out, ni_out);
        $display("\n ---------------------------------------------");

        // Finalizar la simulación
        $finish;
    end

endmodule
