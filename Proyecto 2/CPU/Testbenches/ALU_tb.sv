module ALU_tb;

    // Inputs
    logic [1:0] ALUop;
    logic [15:0] srcA, srcB;

    // Outputs
    logic [15:0] result;

    // Instantiate ALU module
    ALU u_ALU (
        .ALUop(ALUop),
        .srcA(srcA),
        .srcB(srcB),
        .ALUresult(result)
    );

    // Test cases
    initial begin
        // Test case 1: Resta
        ALUop = 2'b00;
        srcA = 5;
        srcB = 2;
        #10; // Esperar algunos ciclos
        $display("Input: a = %d, b = %d, Output: y = %d (a - b)", srcA, srcB, result);

        // Test case 2: Suma
        ALUop = 2'b01;
        srcA = 8;
        srcB = 3;
        #10; // Esperar algunos ciclos
        $display("Input: a = %d, b = %d, Output: y = %d (a + b)", srcA, srcB, result);

        // Finalizar la simulación
        #10 $finish;
    end

endmodule
