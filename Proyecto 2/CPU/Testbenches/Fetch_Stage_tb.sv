module Fetch_Stage_tb;

    // Declaración de variables
    logic clk = 0;
    logic [15:0] instruction_in;
    logic [15:0] instruction_out;
    logic reset = 0;
    logic [15:0] address_out;
    logic [15:0] srcB = 16'b0000000000000000;
    logic [15:0] y;
    logic [15:0] out = 16'b1100110011001100; // Valor inicial para PC de Fetch
	 logic NI = 0;

    // Instancias de módulos
    PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(out),       // La dirección de salida del PC va a la memoria de instrucciones
        .address_out(address_out)
    );
    
    mux_2 mux_2_instance (
        .data0(y),
        .data1(srcB),
        .select(NI), 
        .out(out) 
    );

    ALU ALU_instance (
        .ALUop(3'b001),         // Operación ALU de suma
        .srcA(16'b0000000000000001),
        .srcB(PCregister_instance.address_out),
        .ALUresult(y),
        .flagN(),
        .flagZ()
    );
	 
	 //Corregir ingreso memoria instrucciones: Aqui se deberia ingresar a memoria de instrucciones y obtener la instruccion
	 assign instruction_in = address_out;

    FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_in),
        .instruction_out(instruction_out)
    );
    
    // Generar el clock
    always #10 clk = ~clk;

    // Simulación de cambios en las entradas del registro
    initial begin
        // Ciclo 1:
        $display("Inicio del primer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #10;
        out = 16'b1000100000000111; // PC se actualiza con la dirección de la siguiente instrucción
        #10;
        $display("Final del primer ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_out = %b", instruction_out);
        
        // Ciclo 2:
        $display("\n \n \n");
        $display("Inicio del segundo ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #10;
        out = 16'b1000000100000010; // PC se actualiza con la dirección de la siguiente instrucción
        #10;
        $display("Final del segundo ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_out = %b", instruction_out);
        
        // Ciclo 3:
        $display("\n \n");
        $display("Inicio del tercer ciclo");
        // Esperar al próximo flanco de bajada del reloj
        #10;
        out = 16'b0000001010000001; // PC se actualiza con la dirección de la siguiente instrucción
        #10;
        $display("Final del tercer ciclo");
        $display("Instrucción que sale al registro Fetch: instruction_out = %b", instruction_out);
        
        // Finalizar la simulación
        $finish;
    end

endmodule
