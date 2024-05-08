`timescale 1ps/1ps

module ROM_testbench;

    logic clk = 0;
    logic [15:0] address = 0;
    logic [15:0] q;
    
    
    ROM ROM_instance (
        .address(address),
        .clock(clk),
        .q(q)
    );
    
    // Generación de estímulo
    initial begin
        
        // Simulación de 11 ciclos
        repeat (11) begin
            // Mostrar dirección y valor
            $display("Dirección: %b", q);
				$display("Valor: %b",  q);
            
            // Cambiar la dirección en cada ciclo
            address = address + 1;
            
            // Cambiar el reloj
            #10 clk = ~clk;
        end
        
        // Finalizar la simulación
        $finish;
    end

endmodule
