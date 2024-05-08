_start:
	mov r9, #0
    mov r12, #0

get_values_from_mem:
    ldr r0, [r12]
    mov r8, #1
    add r12, r12, r8

    ldr r1, [r12]
    mov r8, #1
    add r12, r12, r8

    ldr r10, [r12]
    mov r8, #1
    add r12, r12, r8

    ldr r11, [r12]
    mov r8, #1
    add r12, r12, r8

    mov r8, #0

    sub r2, r10, r0
	sub r3, r11, r1

get_sign_dx:
	cmp r2, r8
	beq assign_dx_0
	bgt assign_dx_p
	blt assign_dx_n

get_sign_dy:
	cmp r3, r8
	beq assign_dy_0
	bgt assign_dy_p
	blt assign_dy_n

assign_dx_0:
	mov r4, #0
	b get_sign_dy		

assign_dx_p:
	mov r4, #1
	b get_sign_dy

assign_dx_n:
	mov r4, #-1
	b get_absolute_dx

assign_dy_0:
	mov r5, #0
	b get_exchange

assign_dy_p:
	mov r5, #1
	b get_exchange

assign_dy_n:
	mov r5, #-1
	b get_absolute_dy

get_absolute_dx:
	neg r2, r2
	b get_sign_dy

get_absolute_dy:
	neg r3, r3
	b get_exchange

get_error:
	lsl r6, r3, #1
	sub r6, r6, r2
	b save_values

get_exchange:
	cmp r3, r2
	bgt update_dx_dy
	mov r7, #0
	b get_error

update_dx_dy:
	mov r8, r2
	mov r2, r3
	mov r3, r8
	mov r7, #1
	mov r8, #0
	b get_error

save_values:
	str r0, [r9]
    mov r8, #1
	add r9, r9, r8 
	str r1, [r9]
	add r9, r9, r8
    mov r8, #0
	b loop
	
loop:
    mov r8, #0
	cmp r6, r8
	blt end_loop
	
    mov r8, #1
	cmp r7, r8
    mov r8, #0
	beq update_x

	add r1, r1, r5
		
	b update_e_dx

update_e_dx:
	lsl r8, r2, #1
	sub r6, r6, r8
	mov r8, #0

	b loop

update_x:
	add r0, r0, r4
	b update_e_dx

end_loop:
    mov r8, #1
	cmp r7, r8
    mov r8, #0
	beq update_y_after_loop

	add r0, r0, r4
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
	str r0, [r9]
    mov r8, #1
	add r9, r9, r8
	str r1, [r9]
    add r9, r9, r8
    mov r8, #0
	b get_values_from_mem