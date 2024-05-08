`timescale 1ps/1ps
module Fetch_Stage_tb;
    
   logic clk = 0;
	logic reset = 0;
	logic [15:0] PCaddress_out;	//salida del registro PC que entra al registro pipeline de FETCH
	logic [15:0] jumpAddress = 16'b0000000000000000;  //este valor es de ejemplo, se necesita como entrada al mux pero nunca se utiliza
	logic [15:0] PC_plus1;			//salida del sumador del mux
	logic [15:0] mux_pc;				//salida del mux que va al PC, esta es la dirección leida por el PC
	logic [15:0] instruction_fetch;
	logic [15:0] instruction_decode;
	 
	 
	PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(mux_pc),       
        .address_out(PCaddress_out)
   );
	 
	PCadder PCadder_instance (
        .address(PCaddress_out),		//input: salida del registro PC
        .PC(PC_plus1)					//output: la entrada (input) + 1 que será la siguiente instruccion si no se da un salto
    ); 
	 
	mux_2 mux_2_instance (
        .data0(PC_plus1),
        .data1(jumpAddress),
        .select(1'b0), //se selecciona siempre la entrada 0 que corresponde a la salida del sumador del PC, es decir PC + 1
        .out(mux_pc)
    );
	 
	ROM ROM_instance(
		.address(PCaddress_out),
		.clock(clk),
		.q(instruction_fetch));
		
		
    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_fetch),
        .instruction_out(instruction_decode)
    );
	 
	 	 
    
    always #10 clk = ~clk;
    initial begin
        // Ciclo 1:
		  $display("\n --------------------------------------------------------------------");
        $display("***  1 Primer ciclo  *** \n");
		  $display("Direccion que sale del registro PC = %b", PCaddress_out);
		  $display("Dato que sale del sumador del PC = %b", PCaddress_out);
		  $display("Dato que sale del mux = %b", mux_pc);
		  $display("Instrucción que entra al registro FETCH-DECODE = %b", instruction_fetch);
		  $display("Instrucción que sale al registro FETCH-DECODE = %b", instruction_decode);
		  
		  
        // Esperar al próximo flanco de subida del reloj
        #20;
        
        #20;
        // Ciclo 2:
		  $display("\n --------------------------------------------------------------------");
        $display("***  2 Segundo ciclo  *** \n");
		  $display("Direccion que sale del registro PC = %b", PCaddress_out);
		  $display("Dato que sale del sumador del PC = %b", PCaddress_out);
		  $display("Dato que sale del mux = %b", mux_pc);
		  $display("Instrucción que entra al registro FETCH-DECODE = %b", instruction_fetch);
		  $display("Instrucción que sale al registro FETCH-DECODE = %b", instruction_decode);
		  
        // Esperar al próximo flanco de bajada del reloj
        #20;
		  $display("\n --------------------------------------------------------------------");
        $display("***  3 Tercer ciclo  *** \n");
		  $display("Direccion que sale del registro PC = %b", PCaddress_out);
		  $display("Dato que sale del sumador del PC = %b", PCaddress_out);
		  $display("Dato que sale del mux = %b", mux_pc);
		  $display("Instrucción que entra al registro FETCH-DECODE = %b", instruction_fetch);
		  $display("Instrucción que sale al registro FETCH-DECODE = %b", instruction_decode);
		 
        // Esperar al próximo flanco de bajada del reloj
        #20;
		  $display("\n --------------------------------------------------------------------");
        $display("***  4 Cuarto ciclo  *** \n");
		  $display("Direccion que sale del registro PC = %b", PCaddress_out);
		  $display("Dato que sale del sumador del PC = %b", PCaddress_out);
		  $display("Dato que sale del mux = %b", mux_pc);
		  $display("Instrucción que entra al registro FETCH-DECODE = %b", instruction_fetch);
		  $display("Instrucción que sale al registro FETCH-DECODE = %b", instruction_decode);
		 
        // Esperar al próximo flanco de bajada del reloj
        #20;
		  $display("\n --------------------------------------------------------------------");
		  $display("***  5 Quinto ciclo  *** \n");
		  $display("Direccion que sale del registro PC = %b", PCaddress_out);
		  $display("Dato que sale del sumador del PC = %b", PCaddress_out);
		  $display("Dato que sale del mux = %b", mux_pc);
		  $display("Instrucción que entra al registro FETCH-DECODE = %b", instruction_fetch);
		  $display("Instrucción que sale al registro FETCH-DECODE = %b", instruction_decode);
		 
        // Esperar al próximo flanco de bajada del reloj
        #20;
        
        // Finalizar la simulación
        $finish;
    end

endmodule
