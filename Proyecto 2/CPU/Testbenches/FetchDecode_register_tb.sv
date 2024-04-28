module FetchDecode_register_tb;


    // Definición de señales
    logic clk = 0;                     // Señal de reloj inicializada en bajo
    logic [15:0] instruction_in = 0;   // Entrada del registro
    logic [15:0] instruction_out;      // Salida del registro

    // Instanciar el módulo FetchDecode_register
    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_in),
        .instruction_out(instruction_out)
    );

    // Generar el reloj
    always #10 clk = ~clk;

    // Simular cambios en la entrada del registro
    initial begin
        // Asignar un valor a la entrada del registro
        instruction_in = 16'h1234;
		  $display("Entrada del registro: %h", instruction_in);
			
        // Esperar un ciclo de reloj
        #20;

        $display("Salida (1 ciclo despues): %h", instruction_out);
		  $display("\n --------------------------------------------------------");

        // Asignar otro valor a la entrada del registro
        instruction_in = 16'hABCD;
		  $display("Entrada del registro: %h", instruction_in);
        
        // Esperar un ciclo de reloj
        #20;

        $display("Salida (1 ciclo despues): %h", instruction_out);
		  $display("\n --------------------------------------------------------");
		  
		  // Asignar otro valor a la entrada del registro
        instruction_in = 16'h3241;
		  $display("Entrada del registro: %h", instruction_in);
        
        // Esperar un ciclo de reloj
        #20;

        $display("Salida (1 ciclo despues): %h", instruction_out);
		  $display("\n --------------------------------------------------------");

        // Finalizar la simulación
        $finish;
    end

endmodule
