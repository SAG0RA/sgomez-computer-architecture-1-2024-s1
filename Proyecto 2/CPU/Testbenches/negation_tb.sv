module negation_tb;

    // Definición de señales
    logic [15:0] data_in;       // Datos de entrada
    logic [15:0] negated_data;  // Datos negados

    // Instanciar el módulo negation
    negation negation_inst (
        .data_in(data_in),
        .negated_data(negated_data)
    );

    // Inicializar valores de entrada
    initial begin
        // Prueba 1: Negación de 0000000000000001
        data_in = 16'b0000000000000001;
        #10;  // Esperar un poco
        $display("Prueba 1 - Negación de 0000000000000001: %b", negated_data);
        
        // Prueba 2: Negación de 1111111111111111
        data_in = 16'b1111111111111111;
        #10;  // Esperar un poco
        $display("Prueba 2 - Negación de 1111111111111111: %b", negated_data);
        
        // Prueba 3: Negación de 0101010101010101
        data_in = 16'b0101010101010101;
        #10;  // Esperar un poco
        $display("Prueba 3 - Negación de 0101010101010101: %b", negated_data);
        
        // Prueba 4: Negación de 1010101010101010
        data_in = 16'b1010101010101010;
        #10;  // Esperar un poco
        $display("Prueba 4 - Negación de 1010101010101010: %b", negated_data);
        
        // Finalizar la simulación
        $finish;
    end

endmodule
