module TopModule;

    // Definición de señales
    logic clk;
    logic wre;
    logic [3:0] a1, a2, a3;
    logic [15:0] wd3;
    logic [15:0] rd1, rd2, rd3;
	 
    logic [15:0] a, b, y;
	 
    logic [2:0] ALUop = 1;
	 
    logic [7:0] Immediate = 8'b10000000;
    logic [15:0] SignExtImmediate;
    logic [15:0] ZeroExtImmediate;
	 
	 logic [15:0] out;
	 logic [1:0] select = 1;
	 
	 logic reset = 0;
    logic [15:0] address_in = 16'b1100110011001100;
    logic [15:0] address_out;
	 
	 logic [15:0] data_in;          // Entrada de datos
    logic [15:0] data_out_0;       // Salida de datos 0
    logic [15:0] data_out_1;       // Salida de datos 1
	 
	 logic [15:0] instruction_in;          
    logic [15:0] instruction_out;
	 
	 logic wbs_in, wme_in, mm_in;
    logic [2:0] ALUop_in;
    logic wbs_out, wme_out, mm_out;
    logic [2:0] ALUop_out;
	 
    logic [15:0] ALUresult_in;
    logic [15:0] memData_in;
    logic [15:0] ALUresult_out;
    logic [15:0] memData_out;

	 logic wm_in = 0;
	 logic am_in = 0;
	 logic ni_in = 0;
	 logic wm_out;
	 logic am_out;
	 logic ni_out;
	 
	 logic [15:0] shift_amount; 
    logic [15:0] shifted_data;
	 
	 logic flagN;
	 logic flagZ;
	 
	 logic [3:0] opCode;
	 
    logic wbs, wme, mm;
    logic [1:0] ri;
    logic wm, am, ni;
    
    
    regfile regfile_instance (
        .clk(clk),
        .wre(wre),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2),
        .rd3(rd3)
    );
    
    ALU ALU_instance (
        .ALUop(ALUop), 
        .srcA(a),
        .srcB(b),
        .ALUresult(y),
		  .flagN(flagN),
		  .flagZ(flagZ)
    );
    
    signExtend signExtend_instance (
        .Immediate(Immediate),
        .SignExtImmediate(SignExtImmediate)
    );

    zeroExtend zeroExtend_instance (
        .Immediate(Immediate),
        .ZeroExtImmediate(ZeroExtImmediate)
    );
	 
	 mux_2 mux_2_instance (
        .data0(SignExtImmediate),
        .data1(ZeroExtImmediate),
        .select(select), 
        .out(out) 
    );
	 
	 mux_4 mux_4_instance (
        .data0(a),
        .data1(b),
        .data2(y),
        .data3(out),
        .select(select),
        .out(out)
    );
	 
	 PCadder PCadder_instance (
        .address(y), 
        .PC(a) 
    );
	
    PCregister PCregister_instance (
        .clk(clk),
        .reset(reset),
        .address_in(address_in),
        .address_out(address_out)
    );
	 
	 decoderMemory decoder_instance (
        .data_in(data_in),
        .select(select),
        .data_out_0(data_out_0),
        .data_out_1(data_out_1)
    );
	 
	 FetchDecode_register FetchDecode_register_instance (
        .clk(clk),
        .instruction_in(instruction_in),
        .instruction_out(instruction_out)
    );
	 
	 DecodeExecute_register DecodeExecute_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        .wme_in(wme_in),
        .mm_in(mm_in),
        .ALUop_in(ALUop_in),
		  .wm_in(wm_in),
		  .am_in(am_in),
		  .ni_in(ni_in),
        .wbs_out(wbs_out),
        .wme_out(wme_out),
        .mm_out(mm_out),
        .ALUop_out(ALUop_out),
		  .wm_out(wm_out),
		  .am_out(am_out),
		  .ni_out(ni_out)
    );
	 
	 ExecuteMemory_register ExecuteMemory_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        .wme_in(wme_in),
        .mm_in(mm_in),
        .ALUresult_in(ALUresult_in),
        .memData_in(memData_in),
		  .wm_in(wm_in),
		  .ni_in(ni_in),
        .wbs_out(wbs_out),
        .wme_out(wme_out),
        .mm_out(mm_out),
        .ALUresult_out(ALUresult_out),
        .memData_out(memData_out),
		  .wm_out(wm_out),
		  .ni_out(ni_out)
    );
	 
	 MemoryWriteback_register MemoryWriteback_register_instance (
        .clk(clk),
        .wbs_in(wbs_in),
        .memData_in(memData_in),
        .ALUresult_in(ALUresult_in),
        .wbs_out(wbs_out),
        .memData_out(memData_out),
        .ALUresult_out(ALUresult_out)
    );
	 
	 LogicalShiftLeft shift_inst (
        .data_in(data_in),
        .shift_amount(shift_amount),
        .shifted_data(shifted_data)
    );
	 
	 controlUnit control_inst (
        .opCode(opCode),
		  .flagN(flagN),
		  .flagZ(flagZ),
        .wbs(wbs),
        .wme(wme),
        .mm(mm),
        .ALUop(ALUop),
        .ri(ri),
        .wre(wre),
		  .wm(wm),
		  .am(am),
		  .ni(ni)
    );
    
endmodule
