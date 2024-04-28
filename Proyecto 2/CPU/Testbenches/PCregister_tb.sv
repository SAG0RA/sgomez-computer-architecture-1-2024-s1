module PCregister_tb;

    // Definición de señales
    logic clk = 0;         // Señal de reloj inicializada en bajo
    logic reset = 0;       // Señal de reset inicializada en bajo
    logic [15:0] address_in;    // Entrada del registro
    logic [15:0] address_out;   // Salida del registro

    // Instanciar el módulo PCregister
    PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(address_in),
        .address_out(address_out)
    );

    // Generar el clock
    always #10 clk = ~clk;

    // Simular reset activo
    initial begin
        // Activar el reset
        reset = 1;

        // Esperar un ciclo de reloj
        #20;
		  
		  // Mostrar las direcciones registradas después de activar el reset
        $display("Direccion registrada despues de activar el reset: %h", address_out);

        // Desactivar el reset
        reset = 0;
		  
		  // Inyectar una dirección en el registro (opcional)
        address_in = 16'h1234;

        #20;
		  
		  // Mostrar las direcciones registradas después de desactivar el reset
        $display("Direccion registrada despues de desactivar el reset (reset=0): %h", address_out);

        // Inyectar otra dirección en el registro (opcional)
        address_in = 16'hABCD;
          
        #20;

        // Mostrar las direcciones registradas después de cambiar la entrada
        $display("Direccion registrada despues de cambiar la entrada (reset=0): %h", address_out);
		  
		  // Activar el reset nuevamente
        reset = 1;
		  
		  #20;
		  
		  // Mostrar las direcciones registradas después de activar el reset nuevamente
        $display("Direccion registrada despues de activar el reset nuevamente: %h", address_out);

        // Finalizar la simulación
        $finish;
    end

endmodule
