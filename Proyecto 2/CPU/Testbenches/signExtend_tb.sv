module signExtend_tb;

    // Inputs
    logic [7:0] Immediate;
    
    // Outputs
    logic [15:0] SignExtImmediate;
    
    // Instantiate signExtend module
    signExtend u_signExtend (
        .Immediate(Immediate),
        .SignExtImmediate(SignExtImmediate)
    );

    // Test cases
    initial begin
        // Test case 1: Número positivo
        Immediate = 8'b00001011;
		  $display("Immediate = %b", Immediate);
        #10; // Esperar algunos ciclos
        $display("Test case 1: SignExtImmediate = %b", SignExtImmediate);

        // Test case 2: Número negativo
        Immediate = 8'b10010100;
		  $display("Immediate = %b", Immediate);
        #10; // Esperar algunos ciclos
        $display("Test case 2: SignExtImmediate = %b", SignExtImmediate);

        // Test case 3: Número con el bit más significativo en cero
        Immediate = 8'b01110010;
		  $display("Immediate = %b", Immediate);
        #10; // Esperar algunos ciclos
        $display("Test case 3: SignExtImmediate = %b", SignExtImmediate);

        // Finalizar la simulación
        #10 $finish;
    end

endmodule
