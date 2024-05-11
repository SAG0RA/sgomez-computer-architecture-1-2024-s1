module regfile_tb;

    
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
    always #10 clk = ~clk;
    
    // Inicializar las señales de entrada
    initial begin
		  
        wre = 0; // Desactivar la escritura
        // Leer datos de los puertos
        a1 = 11; // Direccion de lectura del primer puerto
        a2 = 9; // Direccion de lectura del segundo puerto
        a3 = 7; // Direccion de lectura del tercer puerto
		  wd3 = 16'b0000000000001000; // Dato a escribir en el tercer puerto
		  
		  // Imprimir datos de los registros al inicio
		  $display("********* Datos iniciales *********");
        $display("Dato leido del puerto 1: %h", rd1);
        $display("Dato leido del puerto 2: %h", rd2);
        $display("Dato leido del puerto 3: %h", rd3);
        
		  // Esperar un ciclo
        #20;
		  
		  ///////////////////////////////////////////////////////////////////////////////
		  
		  wre = 1; // Activar la escritura
        // Leer datos de los puertos
        a1 = 11; // Direccion de lectura del primer puerto
        a2 = 9; // Direccion de lectura del segundo puerto
        a3 = 7; // Direccion de lectura del tercer puerto
		  wd3 = 16'b0000000000001000; // Dato a escribir en el tercer puerto
		  
		  // Imprimir datos de los registros al inicio
		  $display("********* Datos iniciales *********");
        $display("Dato leido del puerto 1: %h", rd1);
        $display("Dato leido del puerto 2: %h", rd2);
        $display("Dato leido del puerto 3: %h", rd3);
        
		  // Esperar un ciclo
        #20;
		  
		  ///////////////////////////////////////////////////////////////////////////////
		  
		  // Imprimir datos de los registros al inicio
		  $display("********* Datos iniciales *********");
        $display("Dato leido del puerto 1: %h", rd1);
        $display("Dato leido del puerto 2: %h", rd2);
        $display("Dato leido del puerto 3: %h", rd3);
		 
        $finish;
    end
    
endmodule
