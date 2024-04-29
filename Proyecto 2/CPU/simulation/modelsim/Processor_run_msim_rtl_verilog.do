transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/regfile.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/TopModule.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/adder.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/subtractor.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/ALU.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/signExtend.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/zeroExtend.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/mux_2.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/mux_4.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/PCadder.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/PCregister.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/decoderMemory.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/FetchDecode_register.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/DecodeExecute_register.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/ExecuteMemory_register.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/MemoryWriteback_register.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/controlUnit.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/LogicalShiftLeft.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/negation.sv}
vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/comparator.sv}

vlog -sv -work work +incdir+C:/Users/Manuel/Documents/TEC/Arqui\ 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto\ 2/CPU/Testbenches {C:/Users/Manuel/Documents/TEC/Arqui 1/saul/sgomez-computer-architecture-1-2024-s1/Proyecto 2/CPU/Testbenches/Fetch_Stage_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Fetch_Stage_tb

add wave *
view structure
view signals
run -all
