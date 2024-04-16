module pll (
    input logic clk,    // Señal de reloj de entrada
    output logic vga_clk        // Señal de reloj de salida
);

    logic divider;
	 
	 initial begin
		divider = 0;
	 end


    // Flip-flop para dividir por 2
    always @(posedge clk) begin
        divider <= ~divider;
    end

    // Salida es el valor de divider, que cambia con cada flanco de subida de clk
    assign vga_clk = divider;

endmodule