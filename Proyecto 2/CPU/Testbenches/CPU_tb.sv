`timescale 1ps/1ps

module CPU_tb;

    // Definición de señales de clock y reset
    logic clk = 0;
    logic rst = 1;

    // Instancia del módulo CPU
    CPU cpu_inst (
        .clk(clk),
        .rst(rst)
    );

    // Simulación del clock
    always #10 clk = ~clk; // Cambio de clock cada 10 unidades de tiempo

    // Generación de reset y simulación de la CPU
    initial begin
        // Ciclo 1: Instrucción tipo R (add rd=0, rs1=1, rs2=2)
        $display("Ciclo 1: Instrucción tipo R (add rd=0, rs1=1, rs2=2)");
        rst = 0; 
        #100; // Esperar un tiempo suficiente para completar el ciclo
        $display("\n");

        // Ciclo 2: Instrucción tipo J (beq Address = 0x8)
        $display("Ciclo 2: Instrucción tipo J (beq Address = 0x8)");
        #100; 
        $display("\n");

        // Ciclo 3: Instrucción tipo I (str rd=14, Imma=3506)
        $display("Ciclo 3: Instrucción tipo I (str rd=14, Imma=3506)");
        #100; 
        $display("\n");

        // Fin de la simulación
        $finish;
    end

endmodule
