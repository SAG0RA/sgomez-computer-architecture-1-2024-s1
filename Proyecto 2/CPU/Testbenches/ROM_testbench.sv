`timescale 1ps/1ps
module ROM_testbench;

    // Definición de señales
    logic clk;
    logic [15:0] address;
    logic [15:0] q;
    
    // Instancia de la ROM
    ROM ROM_instance (
        .address(address),
        .clock(clk),
        .q(q)
    );
    always #10 clk = ~clk;

    initial begin
        clk = 0;
        address = 0;        
        repeat (20) begin
				#10
            $display("Dirección: %d", address);
            address = address + 1;
				#30
            $display("Valor en %d: %b", address, q);
        end
        
        // Finalizar la simulación
        $finish;
    end

endmodule
