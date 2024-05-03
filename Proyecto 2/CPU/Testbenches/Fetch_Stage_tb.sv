module Fetch_Stage_tb;
    // Declaración de variables
    logic clk = 0;
	 logic reset = 0;
    logic [15:0] instruction_fetch;
    logic [15:0] instruction_decode;
    logic [15:0] address_pc;
	 logic [15:0] pc_input = 16'b0000000000000000; // Valor inicial para PC de Fetch
    logic [15:0] srcB = 16'b0000000000000000; //Simulacion entrada srcB de etapa ejecucion
    logic [15:0] y;
	 logic NI = 0; //Simulacion de NextInstruction de Control

    PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(pc_input),       
        .address_out(address_pc)
    );
    
    mux_2 mux_2_instance (
        .data0(y),
        .data1(srcB),
        .select(NI), 
        .out(pc_input) 
    );

    ALU ALU_instance (
        .ALUop(3'b001), // Operación ALU de suma
        .srcA(16'b0000000000000001),// Sumando 1 al la direccion del registro del PC
        .srcB(PCregister_instance.address_out),
        .ALUresult(y),
        .flagN(),
        .flagZ()
    );
	 
	 // INGRESAR A MEMORIA DE INSTRUCCIONES input:address_pc output:instruction_in
	 assign instruction_fetch = address_pc;

    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_fetch),
        .instruction_out(instruction_decode)
    );
    
    always #10 clk = ~clk;
    // Simulación de cambios en las entradas del registro
    initial begin
        // Ciclo 1:
        $display("Inicio del primer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;
        pc_input =  16'b0000000000000001; //Direccion Instruccion 1
        #20;
        $display("Final del primer ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_decode = %b", instruction_decode);
        
        // Ciclo 2:
        $display("\n \n \n");
        $display("Inicio del segundo ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;
        pc_input =  16'b0000000000000010; //Direccion Instruccion 2
        #20;
        $display("Final del segundo ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_decode = %b", instruction_decode);
        
        // Ciclo 3:
        $display("\n \n");
        $display("Inicio del tercer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #20;
        pc_input =  16'b0000000000000011; //Direccion Instruccion 3
        #20;
        $display("Final del tercer ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_decode = %b", instruction_decode);
        
        // Finalizar la simulación
        $finish;
    end

endmodule
