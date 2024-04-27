module mux_2_tb;

    // Inputs
    logic [15:0] data0, data1;
    logic select;
    
    // Output
    logic [15:0] out;

    // Instantiate the mux_2 module
    mux_2 u_mux_2 (
        .data0(data0),
        .data1(data1),
        .select(select),
        .out(out)
    );

    // Test cases
    initial begin
        // Test case 1: select = 0
        data0 = 16'hAAAA;
        data1 = 16'hBBBB;
        select = 0;
		  $display("Dato 0 = %h", data0);
		  $display("Dato 1 = %h", data1);
        #10; // Wait a few cycles
        $display("Select 0: out = %h", out);
		  $display("\n");
        // Test case 2: select = 1
        data0 = 16'hAAAA;
        data1 = 16'hBBBB;
        select = 1;
		  $display("Dato 0 = %h", data0);
		  $display("Dato 1 = %h", data1);
        #10; // Wait a few cycles
        $display("Select 1: out = %h", out);

        // Additional test cases can be added here
        
        // Finish the simulation
        #10;
        $finish;
    end

endmodule
