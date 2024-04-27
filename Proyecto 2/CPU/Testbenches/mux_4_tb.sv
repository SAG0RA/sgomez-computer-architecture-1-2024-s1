module mux_4_tb;

    // Inputs
    logic [15:0] data0, data1, data2, data3;
    logic [1:0] select;

    // Output
    logic [15:0] out;

    // Instantiate the mux_4 module
    mux_4 u_mux_4 (
        .data0(data0),
        .data1(data1),
        .data2(data2),
        .data3(data3),
        .select(select),
        .out(out)
    );

    // Initialize inputs
    initial begin
        data0 = 16'hAAAA;
        data1 = 16'hBBBB;
        data2 = 16'hCCCC;
        data3 = 16'hDDDD;
        select = 2'b00; // Selecciona data0 inicialmente
		  $display("Dato 0 = %h", data0);
		  $display("Dato 1 = %h", data1);
		  $display("Dato 2 = %h", data2);
		  $display("Dato 3 = %h", data3);
		  #10
		  $display("Select 0: out = %h", out);
		  $display("\n");
		 
        // Cambiar select a lo largo del tiempo y mostrar la salida
        #10 select = 2'b01; // Cambiar a data1
		  $display("Dato 0 = %h", data0);
		  $display("Dato 1 = %h", data1);
		  $display("Dato 2 = %h", data2);
		  $display("Dato 3 = %h", data3);
		  #10
		  $display("Select 1: out = %h", out);
		  $display("\n");
        #10 select = 2'b10; // Cambiar a data2
		  $display("Dato 0 = %h", data0);
		  $display("Dato 1 = %h", data1);
		  $display("Dato 2 = %h", data2);
		  $display("Dato 3 = %h", data3);
		  #10
		  $display("Select 2: out = %h", out);
		  $display("\n");
        #10 select = 2'b11; // Cambiar a data3
		  $display("Dato 0 = %h", data0);
		  $display("Dato 1 = %h", data1);
		  $display("Dato 2 = %h", data2);
		  $display("Dato 3 = %h", data3);
		  #10
		  $display("Select 3: out = %h", out);
		  $display("\n");

        // Finalizar la simulación
        #10 $finish;
    end

endmodule
