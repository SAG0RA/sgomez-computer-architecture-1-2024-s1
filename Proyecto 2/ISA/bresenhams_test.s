.section .data
x0:		.word 4	@ coordenada x de inicio
y0:		.word 0 @ coordenada y de inicio
x1:		.word 8 @ coordenada x de final
y1:		.word 9 @ coordenada y de final

direccion:	.space 62500

.section .text
.globl _start

_start:
	mov r0, #1		@ Carga x0 en r0
	mov r1, #0		@ Carga y0 en r1

	mov r10, #7		@ Carga x1 en r2
	mov r11, #0		@ Carga y1, en r3

	sub r2, r10, r0		@ Obtiene el diferencial dx y lo guarda en r4
	sub r3, r11, r1		@ Obtiene el diferencial dy y lo guarda en r5

get_sign_dx:
	cmp r2, #0		@ Compara dx con 0
	beq assign_dx_0		@ Si es igual a 0, asignar 0
	bgt assign_dx_p		@ Si es mayor a 0, asignar 1
	blt assign_dx_n		@ Si es menor a 0, asingar -1

get_sign_dy:
	cmp r3, #0		@ Compara dy con 0
	beq assign_dy_0		@ Si es igual a 0, asignar 0
	bgt assign_dy_p		@ Si es mayor a 0, asignar 1
	blt assign_dy_n		@ Si es menor a 0, asingar -1

assign_dx_0:
	mov r4, #0		@ asignar 0
	b get_sign_dy		

assign_dx_p:
	mov r4, #1		@ asignar 1
	b get_sign_dy

assign_dx_n:
	mov r4, #-1		@ asignar -1
	b get_absolute_dx

assign_dy_0:
	mov r5, #0		@ asignar 0
	b get_exchange

assign_dy_p:
	mov r5, #1		@ asignar 1
	b get_exchange

assign_dy_n:
	mov r5, #-1		@ asignar -1
	b get_absolute_dy

get_absolute_dx:
	neg r2, r2
	b get_sign_dy

get_absolute_dy:
	neg r3, r3
	b get_exchange

get_error:
	lsl r6, r3, #1		@ Hacer la multiplicacion 2dy
	sub r6, r6, r2		@ Restar dx a 2dy para obtener e

	b save_values

get_exchange:
	cmp r3, r2		@ Compara dy con dx
	bgt update_dx_dy	@ Si es mayor, dx = dy y dy = dx, ex_change = 1
	mov r7, #0		@ Si no, ex_change = 0
	ldr r9, =direccion	@ Se carga la direccion
	b get_error

update_dx_dy:
	mov r8, r2		@ Usar r9 como temp de dx
	mov r2, r3		@ Guardar dy en r2
	mov r3, r8		@ Guardar en r3, r9
	mov r7, #1		@ Ex_change = 1
	mov r8, #0		@ Vaciar r9
	ldr r9, =direccion	@ Cargar direccion
	b get_error

save_values:
	str r0, [r9]		@ Guardar x en memoria
	add r9, #4		@ Sumar 4 bytes a la direccion 
	str r1, [r9]		@ Guardar y en memoria
	add r9, #4		@ Sumar 4 bytes a la direccion
	b loop
	
loop:
	cmp r6, #0		@ Comparar e con 0
	blt end_loop		@ Si es menor, salir
	
	cmp r7, #1		@ Comparar ex_change con 1
	beq update_x		@ Si es igual, actualizar x

	add r1, r1, r5		@ Si no, actualizar y = y + S2
		
	b update_e_dx

update_e_dx:
	lsl r8, r2, #1		@ Multiplica dx*2 y guardar en r9
	sub r6, r6, r8		@ Hacer la operacion e = e - 2dx
	mov r8, #0		@ Reiniciar r9

	b loop

update_x:
	add r0, r0, r4		@ Actualizar x = x + s1
	b update_e_dx

end_loop:
	cmp r7, #1		@ Comprar ex_change con 1
	beq update_y_after_loop	@ Si es 1, actualizar y

	add r0, r0, r4		@ Si no, actualizar x
	b update_e_dy

update_e_dy:
	lsl r8, r3, #1
	add r6, r6, r8
	mov r8, #0
	b check_x_end	

update_y_after_loop:
	add r1, r1, r5
	b update_e_dy

check_x_end:
	cmp r0, r10
	beq check_y_end
	b save_values

check_y_end:
	cmp r1, r11
	beq last_save
	b save_values

last_save:
	str r0, [r9]		@ Guardar x en memoria
	add r9, #4		@ Sumar 4 bytes a la direccion 
	str r1, [r9]		@ Guardar y en memoria
	b exit

exit:
	bx lr




















