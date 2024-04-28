module decoderMemory_tb;

    
    // Definición de señales
    logic [15:0] data_in;          // Entrada de datos
    logic select;                   // Señal de selección
    logic [15:0] data_out_0;       // Salida de datos 0
    logic [15:0] data_out_1;       // Salida de datos 1

    // Instanciar el módulo decoderMemory
    decoderMemory decoder_instance (
        .data_in(data_in),
        .select(select),
        .data_out_0(data_out_0),
        .data_out_1(data_out_1)
    );

    // Simular el cambio de entrada
    initial begin
        // Inicializar las señales
        data_in = 16'hABCD;  // Datos de entrada
        select = 0;          // Inicialmente seleccionar la salida 1
		  #5
        // Mostrar las salidas iniciales
		  $display("\n -----------------------------------------------------------------");
		  $display("Entrada inicial: %h", data_in);
		  $display("Select: %b", select);
        $display("Salida 0 inicial: %h", data_out_0);
        $display("Salida 1 inicial: %h", data_out_1);

        // Cambiar la selección a la salida 0
        select = 1;
        // Esperar un ciclo de reloj
        #5
        // Mostrar las salidas después del cambio de selección
		  $display("\n -----------------------------------------------------------------");
		  $display("Entrada después del cambio de selección: %h", data_in);
		  $display("Select: %b", select);
        $display("Salida 0 después del cambio de selección: %h", data_out_0);
        $display("Salida 1 después del cambio de selección: %h", data_out_1);

        // Cambiar los datos de entrada
        data_in = 16'h1234;
        // Esperar un ciclo de reloj
        #5
        // Mostrar las salidas después del cambio de datos de entrada
		  $display("\n -----------------------------------------------------------------");
		  $display("Entrada después del cambio de datos de entradan: %h", data_in);
		  $display("Select: %b", select);
        $display("Salida 0 después del cambio de datos de entrada: %h", data_out_0);
        $display("Salida 1 después del cambio de datos de entrada: %h", data_out_1);

        // Finalizar la simulación
        $finish;
    end

endmodule
