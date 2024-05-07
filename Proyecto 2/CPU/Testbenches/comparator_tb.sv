module comparator_tb;

    // Definición de señales
    logic [15:0] num1;    // Primer número de entrada
    logic [15:0] num2;    // Segundo número de entrada
    logic [15:0] result;  // Resultado de la comparación

    // Instanciar el módulo comparator
    comparator comparator_inst (
        .num1(num1),
        .num2(num2),
        .result(result)
    );

    // Inicializar valores de entrada
    initial begin
        // Prueba 1: num1 = num2
        num1 = 16'b0000000000000001;
        num2 = 16'b0000000000000001;
		  $display("num1 = %b", num1);
		  $display("num2 = %b", num2);
        #10;  // Esperar un poco
        $display("Prueba 1 - num1 = num2: %b", result);
		  $display("\n -----------------------------------");
        
        // Prueba 2: num1 > num2
        num1 = 16'b0000000000000100;
        num2 = 16'b0000000000000001;
		  $display("num1 = %b", num1);
		  $display("num2 = %b", num2);
        #10;  // Esperar un poco
        $display("Prueba 2 - num1 > num2: %b", result);
		  $display("\n -----------------------------------");
        
        // Prueba 3: num1 < num2
        num1 = 16'b0000000000000001;
        num2 = 16'b0000000000000100;
		  $display("num1 = %b", num1);
		  $display("num2 = %b", num2);
        #10;  // Esperar un poco
        $display("Prueba 3 - num1 < num2: %b", result);
		  $display("\n -----------------------------------");
        
        // Finalizar la simulación
        $finish;
    end

endmodule