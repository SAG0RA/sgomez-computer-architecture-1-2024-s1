`timescale 1ps/1ps
module Fetch_Stage_tb;
    // Declaración de variables
    logic clk = 0;
	 logic reset = 0;
    logic [15:0] instruction_fetch;
    logic [15:0] instruction_decode;
	 logic [15:0] alu_pc;
	 logic [15:0] mux_pc;
    logic [15:0] address_pc = 16'b0000000000000000;
    logic [15:0] srcB = 16'b0000000000000000; 			//Simulacion entrada srcB de etapa ejecucion
	 logic NI = 0; 												//Simulacion de NextInstruction de Control

   PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(address_pc),       
        .address_out(address_pc)
   );
    
 
	ROM ROM_instance(
		.address(PCregister_instance.address_out),
		.clock(clk),
		.q(instruction_fetch));
		
		
	mux_2 mux_2_instance (
        .data0(ALU_instance.ALUresult),
        .data1(srcB),
        .select(NI), 
        .out(mux_pc) 
    );

	 
    ALU ALU_instance (
        .ALUop(3'b001), 											// Operación ALU de suma
        .srcA(16'b0000000000000001),							// Sumando 1 al la direccion del registro del PC
        .srcB(PCregister_instance.address_out),
        .ALUresult(alu_pc),
        .flagN(),
        .flagZ()
    );

    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_fetch),
        .instruction_out(instruction_decode)
    );
	 
	 	 
    
    always #10 clk = ~clk;
    initial begin
        // Ciclo 1:
        $display("Inicio del primer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;
        address_pc =  16'b0000000000000010; //Direccion Instruccion 2
        #20;
        $display("Final del primer ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_decode = %b", instruction_decode);
        
        // Ciclo 2:
        $display("\n \n \n");
        $display("Inicio del segundo ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;
        address_pc =  16'b0000000000000100; //Direccion Instruccion 4
        #20;
        $display("Final del segundo ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_decode = %b", instruction_decode);
        
        // Ciclo 3:
        $display("\n \n");
        $display("Inicio del tercer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;
        address_pc =  16'b0000000000001000; //Direccion Instruccion 8
        #20;
        $display("Final del tercer ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_decode = %b", instruction_decode);
        
        // Finalizar la simulación
        $finish;
    end

endmodule
