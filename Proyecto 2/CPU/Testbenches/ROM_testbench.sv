`timescale 1ps/1ps

module ROM_testbench;

    logic clk;
    logic [15:0] address;
    logic [15:0] q;
    
    
    ROM ROM_instance (
        .address(address),
        .clock(clk),
        .q(q)
    );
    
    // Generación de estímulo
    initial begin
        clk = 0;
		  address = 0;
        // Simulación de 11 ciclos
        repeat (20) begin
            // Mostrar dirección y valor
            $display("Dirección: %d", address);
				$display("Valor: %b",  q);
            
            // Cambiar la dirección en cada ciclo
            address = address + 1;
            
            // Cambiar el reloj
            #10; 
				
				clk = ~clk;
				
				#10;
        end
        
        // Finalizar la simulación
        $finish;
    end

endmodule
