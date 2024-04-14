transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/proyecto_2/CPU {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/proyecto_2/CPU/Processor.sv}

vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/proyecto_2/CPU/TestBenches {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/proyecto_2/CPU/TestBenches/Processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Processor_tb

add wave *
view structure
view signals
run -all
