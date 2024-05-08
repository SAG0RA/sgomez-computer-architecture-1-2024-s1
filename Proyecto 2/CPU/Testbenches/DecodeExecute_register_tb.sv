module DecodeExecute_register_tb;

    // Definición de señales
    logic clk = 0;         // Señal de reloj inicializada en bajo
    logic wbs_in = 0;      // Entrada wbs_in
    logic wme_in = 0;      // Entrada wme_in
    logic mm_in = 0;       // Entrada mm_in
    logic [2:0] ALUop_in = 3'b000;  // Entrada ALUop_in
	 logic wm_in = 0;
	 logic am_in = 0;
	 logic ni_in = 0;
	 logic [15:0] srcA_in = 16'b0000000000000010;  // Entrada srcA_in
	 logic [15:0] srcB_in = 16'b0000000000000011;  // Entrada srcB_in


    logic wbs_out;         // Salida wbs_out
    logic wme_out;         // Salida wme_out
    logic mm_out;          // Salida mm_out
    logic [2:0] ALUop_out; // Salida ALUop_out
	 logic wm_out;
	 logic am_out;
	 logic ni_out;
	 logic [15:0] srcA_out;  // Salida srcA_out
	 logic [15:0] srcB_out;  // Salida srcB_out

    // Instanciar el módulo DecodeExecute_register
    DecodeExecute_register DecodeExecute_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        .wme_in(wme_in),
        .mm_in(mm_in),
        .ALUop_in(ALUop_in),
		  .wm_in(wm_in),
		  .am_in(am_in),
		  .ni_in(ni_in),
        .wbs_out(wbs_out),
        .wme_out(wme_out),
        .mm_out(mm_out),
        .ALUop_out(ALUop_out),
		  .wm_out(wm_out),
		  .am_out(am_out),
		  .ni_out(ni_out)
    );

    // Generar el clock
    always #10 clk = ~clk;

    // Simular cambios en las entradas del registro
    initial begin
        // Ciclo 1: Asignar valores a las entradas del registro
        wbs_in = 1;
        wme_in = 0;
        mm_in = 1;
        ALUop_in = 3'b001;
		  wm_in = 1;
		  am_in = 1;
		  ni_in = 1;
		  srcA_in = 16'b0000000000000110;
		  srcB_in = 16'b0000000000000111;
		  

		  $display("Entradas: wbs_in=%b, wme_in=%b, mm_in=%b, ALUop_in=%b, wm_in=%b, am_in=%b, ni_in=%b, srcA_in=%b, srcB_in=%b",
                 wbs_in, wme_in, mm_in, ALUop_in, wm_in, am_in, ni_in, srcA_in, srcB_in);
					  
        // Esperar un ciclo de reloj
        #20;

        // Ciclo 1: Mostrar las salidas del registro
		  $display("Ciclo 1");
        $display("Salidas (1 Ciclo despues): wbs_out=%b, wme_out=%b, mm_out=%b, ALUop_out=%b, wm_out=%b, am_out=%b, ni_out=%b, srcA_out=%b, srcB_out=%b",
                 wbs_out, wme_out, mm_out, ALUop_out, wm_out, am_out, ni_out, srcA_out, srcB_out);
		  $display("\n -----------------------------------------------------");
		  
        // Ciclo 2: Asignar nuevos valores a las entradas del registro
        wbs_in = 0;
        wme_in = 1;
        mm_in = 0;
        ALUop_in = 3'b010;
		  wm_in = 0;
		  am_in = 0;
		  ni_in = 0;
		  srcA_in = 16'b0000000000000001;
		  srcB_in = 16'b0000000000000101;

		  $display("Entradas: wbs_in=%b, wme_in=%b, mm_in=%b, ALUop_in=%b, wm_in=%b, am_in=%b, ni_in=%b, srcA_in=%b, srcB_in=%b",
                 wbs_in, wme_in, mm_in, ALUop_in,wm_in, am_in, ni_in, srcA_in, srcB_in);
					  
        // Esperar un ciclo de reloj
        #20;

        // Ciclo 2: Mostrar las salidas del registro
		  $display("Ciclo 2");
        $display("Salidas (1 Ciclo despues): wbs_out=%b, wme_out=%b, mm_out=%b, ALUop_out=%b, wm_out=%b, am_out=%b, ni_out=%b, srcA_out=%b, srcB_out=%b",
                 wbs_out, wme_out, mm_out, ALUop_out, wm_out, am_out, ni_out,  srcA_out, srcB_out);
		  $display("\n -----------------------------------------------------");

        // Finalizar la simulación
        $finish;
    end

endmodule
