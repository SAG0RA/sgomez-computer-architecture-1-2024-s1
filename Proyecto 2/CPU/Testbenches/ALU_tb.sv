module ALU_tb;

    // Inputs
    logic [2:0] ALUop;
    logic [15:0] srcA, srcB;

    // Outputs
    logic [15:0] result;
    logic flagN, flagZ;

    // Instantiate ALU module
    ALU u_ALU (
        .ALUop(ALUop),
        .srcA(srcA),
        .srcB(srcB),
        .ALUresult(result),
        .flagN(flagN),
        .flagZ(flagZ)
    );

    // Test cases
    initial begin
        // Test case 1: Resta
        ALUop = 3'b000;
        srcA = 5;
        srcB = 2;
        #10; // Esperar algunos ciclos
        $display("Input: a = %d, b = %d, Output: y = %d (a - b), flagN = %b, flagZ = %b", srcA, srcB, result, flagN, flagZ);
		  $display("\n --------------------------------------------------------------------------");
		  
        // Test case 2: Suma
        ALUop = 3'b001;
        srcA = 8;
        srcB = 3;
        #10; // Esperar algunos ciclos
        $display("Input: a = %d, b = %d, Output: y = %d (a + b), flagN = %b, flagZ = %b", srcA, srcB, result, flagN, flagZ);
		  $display("\n --------------------------------------------------------------------------");
		  
        // Test case 3: Desplazamiento lógico hacia la izquierda
        ALUop = 3'b010;
        srcA = 16'b1100110011001100;
        srcB = 4;
        #10; // Esperar algunos ciclos
        $display("Input: a = %b, b = %d, Output: y = %b (a << b), flagN = %b, flagZ = %b", srcA, srcB, result, flagN, flagZ);
		  $display("\n --------------------------------------------------------------------------");
		  
        // Test case 4: Negación
        ALUop = 3'b011;
        srcA = 16'b1100110011001100;
        srcB = 0; // No se usa en la operación de negación
        #10; // Esperar algunos ciclos
        $display("Input: a = %b, b = %d, Output: y = %b (~a), flagN = %b, flagZ = %b", srcA, srcB, result, flagN, flagZ);
		  $display("\n --------------------------------------------------------------------------");
		  
        // Test case 5: Comparación
        ALUop = 3'b0101;
        srcA = 10;
        srcB = 7;
        #10; // Esperar algunos ciclos
        $display("Input: a = %d, b = %d, Output: y = %d (a == b ? 0 : a > b ? 1 : 2), flagN = %b, flagZ = %b", srcA, srcB, result, flagN, flagZ);

        // Finalizar la simulación
        #10 $finish;
    end

endmodule
