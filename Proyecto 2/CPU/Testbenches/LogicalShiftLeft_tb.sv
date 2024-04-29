module LogicalShiftLeft_tb;

    // Definición de señales
    logic [15:0] data_in;       // Datos de entrada
    logic [15:0] shift_amount;  // Cantidad de desplazamiento
    logic [15:0] shifted_data;  // Datos desplazados

    // Instanciar el módulo LogicalShiftLeft
    LogicalShiftLeft shift_inst (
        .data_in(data_in),
        .shift_amount(shift_amount),
        .shifted_data(shifted_data)
    );

    // Inicializar valores de entrada
    initial begin
        // Prueba 1: Desplazamiento a la izquierda por 1 bit
        data_in = 16'b0000000000000001;
        shift_amount = 1;
        #10;  // Esperar un poco
        $display("Prueba 1 - Desplazamiento de 0000000000000001 a la izquierda por 1 bit: %b", shifted_data);
        
        // Prueba 2: Desplazamiento a la izquierda por 4 bits
        data_in = 16'b0000000000000001;
        shift_amount = 4;
        #10;  // Esperar un poco
        $display("Prueba 2 - Desplazamiento de 0000000000000001 a la izquierda por 4 bits: %b", shifted_data);
        
        // Prueba 3: Desplazamiento a la izquierda por 8 bits
        data_in = 16'b0000000000000001;
        shift_amount = 8;
        #10;  // Esperar un poco
        $display("Prueba 3 - Desplazamiento de 0000000000000001 a la izquierda por 8 bits: %b", shifted_data);
        
        // Prueba 4: Desplazamiento a la izquierda por 12 bits
        data_in = 16'b0000000000000001;
        shift_amount = 12;
        #10;  // Esperar un poco
        $display("Prueba 4 - Desplazamiento de 0000000000000001 a la izquierda por 12 bits: %b", shifted_data);
        
        // Finalizar la simulación
        $finish;
    end

endmodule
