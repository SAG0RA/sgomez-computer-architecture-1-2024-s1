module regfile_tb;

    // Parámetros del testbench
    parameter CLK_PERIOD = 10; // Periodo del reloj en unidades de tiempo
    
    // Definición de señales
    logic clk = 0;
    logic wre = 0;
    logic [3:0] a1, a2, a3;
    logic [15:0] wd3;
    logic [15:0] rd1, rd2, rd3;
    
    // Instanciar el módulo regfile
    regfile dut (
        .clk(clk),
        .wre(wre),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2),
        .rd3(rd3)
    );
    
    // Generar un pulso de reloj cada periodo
    always #(CLK_PERIOD / 2) clk = ~clk;
    
    // Inicializar las señales de entrada
    initial begin
        // Esperar un poco antes de comenzar las operaciones
        #(CLK_PERIOD * 5);
		  
        wre = 0; // Desactivar la escritura
        // Leer datos de los puertos
        a1 = 0; // Direccion de lectura del primer puerto
        a2 = 1; // Direccion de lectura del segundo puerto
        a3 = 2; // Direccion de lectura del tercer puerto
        #CLK_PERIOD; // Esperar un ciclo de reloj
		  
		  // Imprimir datos de los registros al inicio
		  $display("********* Datos iniciales *********");
        $display("Dato leido del puerto 1: %h", rd1);
        $display("Dato leido del puerto 2: %h", rd2);
        $display("Dato leido del puerto 3: %h", rd3);
		  
		  // Escribir datos
        wre = 1;
        a3 = 0; // Direccion de escritura
        wd3 = 16'hABCD; // Dato a escribir
		  
        #CLK_PERIOD; // Esperar un ciclo de reloj
		  
		  // Escribir datos
        wre = 1;
        a3 = 1; // Direccion de escritura
        wd3 = 16'h29CA; // Dato a escribir
		  
		  #CLK_PERIOD; // Esperar un ciclo de reloj
		  
		  // Escribir datos
        wre = 1;
        a3 = 2; // Direccion de escritura
        wd3 = 16'hC11F; // Dato a escribir
		  
		  #CLK_PERIOD; // Esperar un ciclo de reloj
        
        wre = 0; // Desactivar la escritura
        // Leer datos de los puertos
        a1 = 0; // Direccion de lectura del primer puerto
        a2 = 1; // Direccion de lectura del segundo puerto
        a3 = 2; // Direccion de lectura del tercer puerto
        #CLK_PERIOD; // Esperar un ciclo de reloj
		  
		  // Imprimir datos guardados en los registros
		  $display("********* Datos guardados *********");
        $display("Dato leido del puerto 1: %h", rd1);
        $display("Dato leido del puerto 2: %h", rd2);
        $display("Dato leido del puerto 3: %h", rd3);
        
        // Terminar la simulación
        $finish;
    end
    
endmodule
