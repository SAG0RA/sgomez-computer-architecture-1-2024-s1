module HazardDetectionUnit_tb();

    logic [3:0] current_opcode;
    logic [3:0] previous_opcode;
    logic [3:0] previous_previous_opcode;
    logic stall_current;
    logic stall_previous;

    HazardDetectionUnit dut (
        .current_opcode(current_opcode),
        .previous_opcode(previous_opcode),
        .previous_previous_opcode(previous_previous_opcode),
        .stall_current(stall_current),
        .stall_previous(stall_previous)
    );
    logic clk = 0;
    always #5 clk = ~clk; 

    initial begin
        // Caso 1: No debería haber stall
        current_opcode = 4'b0000;  // Opcode cualquiera
        previous_opcode = 4'b0000; // Opcode cualquiera
        previous_previous_opcode = 4'b0000; // Opcode cualquiera
        #10;  // Espera para que los cambios se reflejen
        assert(stall_current === 1'b0);
        assert(stall_previous === 1'b0);

        // Caso 2: stall_current activo debido al current_opcode
        current_opcode = 4'b1010;  // Opcode que activa stall_current
        #10;  // Espera para que los cambios se reflejen
        assert(stall_current === 1'b1);
        assert(stall_previous === 1'b0);

        // Caso 3: stall_previous activo debido al previous_opcode
        current_opcode = 4'b0000;  // Reset current_opcode
        previous_opcode = 4'b1010; // Opcode que activa stall_previous
        #10;  // Espera para que los cambios se reflejen
        assert(stall_current === 1'b0);
        assert(stall_previous === 1'b1);

        // Caso 4: stall_previous activo debido al previous_previous_opcode
        previous_opcode = 4'b0000; // Reset previous_opcode
        previous_previous_opcode = 4'b1010; // Opcode que activa stall_previous
        #10;  // Espera para que los cambios se reflejen
        assert(stall_current === 1'b0);
        assert(stall_previous === 1'b1);

        $display("Testbench completado correctamente!");
        $finish; 
    end

endmodule
