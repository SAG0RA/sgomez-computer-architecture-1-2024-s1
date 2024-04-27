module subtractor_tb;

  // Inputs
  logic [15:0] a, b;
  
  // Outputs
  logic [15:0] y;
  
  // Instantiate the subtractor module
  subtractor u_subtractor (
    .a(a),
    .b(b),
    .y(y)
  );

  // Monitor the output
  always @(posedge y) begin
    $display("Input: a = %d, b = %d, Output: y = %d (a - b)", a, b, y);
  end

  // Test cases
  initial begin
    // Test case 1
    a = 0; b = 0; #0; // Espera antes de la asignación
    $display("Test case 1:");
    $monitor("Input: a = %d, b = %d, Output: y = %d (a - b)", a, b, y);
    #5
    // Test case 2
    a = 2; b = 1; #0;
    $display("Test case 2:");
    #5
    // Test case 3
    a = 1; b = 2; #0;
    $display("Test case 3:");
    #5
    // Test case 4
    a = 1000; b = 333; #0;
    $display("Test case 4:");
    #5
    // Test case 5
    a = 250; b = 1500; #0;
    $display("Test case 5:");
    
    // Finalizar la simulación
    #300 $finish;
  end

endmodule
