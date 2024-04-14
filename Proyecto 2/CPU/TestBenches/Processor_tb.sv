module Processor_tb;

    // Parámetros del testbench
    logic clk = 0;
    logic reset = 1;
    logic [31:0] WriteData, DataAdr, ReadData;
    logic MemWrite;

    // Instanciación del módulo bajo prueba
    Processor dut (
        .clk(clk),
        .reset(reset),
        .WriteData(WriteData),
        .DataAdr(DataAdr),
        .ReadData(ReadData),
        .MemWrite(MemWrite)
    );

    // Proceso para generar el reloj
    always #5 clk = ~clk;

    // Proceso de reset
    initial begin
        reset = 1;
        #10 reset = 0;

        // Simular operaciones
        // Aquí puedes simular operaciones adicionales según sea necesario

        // Finalizar la simulación
        #1000 $finish;
    end

endmodule
