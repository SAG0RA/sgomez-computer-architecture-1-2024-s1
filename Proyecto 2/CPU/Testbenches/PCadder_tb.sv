module PCadder_tb;

    // Inputs
    logic [15:0] address;

    // Outputs
    logic [15:0] PC;

    // Instantiate the PCadder module
    PCadder u_PCadder (
        .address(address),
        .PC(PC)
    );

    // Test cases
    initial begin
        // Test case 1
        address = 16'h0000;
        #10; // Wait for some cycles
        $display("Test case 1: Initial address = %b, PC = %b", address, PC);

        // Test case 2
        address = 16'h1234;
        #10; // Wait for some cycles
        $display("Test case 2: Initial address = %b, PC = %b", address, PC);

        // Test case 3
        address = 16'hFFFF;
        #10; // Wait for some cycles
        $display("Test case 3: Initial address = %b, PC = %b", address, PC);

        // Test case 4
        address = 16'h8000;
        #10; // Wait for some cycles
        $display("Test case 4: Initial address = %b, PC = %b", address, PC);

        // Test case 5
        address = 16'hFFFF;
        #10; // Wait for some cycles
        $display("Test case 5: Initial address = %b, PC = %b", address, PC);

        // Finish simulation
        #10 $finish;
    end

endmodule
