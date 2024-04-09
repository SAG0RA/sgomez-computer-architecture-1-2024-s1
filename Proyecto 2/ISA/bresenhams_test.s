.section .data
direccion:	.space 62500

.section .text
.global _start
_start:
	LDR R9, =direccion
	LDR R0, =4			@ x0
	LDR R1, =0			@ y0
	LDR R2, =8			@ x1
	LDR R3, =9			@ y1
	
	SUB R2, R2, R0		@ dx = x1 - x0
	SUB R3, R3, R1		@ dy = y1 - y0
	
signo_s1:
	CMP R2, #0			@ Compara r2 con 0
    MOVEQ R4, #0		@ Si es igual a 0, entonces r4 = 0
    MOVGT R4, #1		@ Si es mayor que 0, entonces r4 = 1
    MOVLT R4, #-1		@ Si es menor que 0, entonces r4 = -1
	
signo_s2:
	CMP R3, #0			@ Compara r3 con 0
    MOVEQ R5, #0		@ Si es igual a 0, entonces r5 = 0
    MOVGT R5, #1		@ Si es mayor que 0, entonces r5 = 1
    MOVLT R5, #-1		@ Si es menor que 0, entonces r5 = -1
	
ex_change:
	CMP R3, R2
	MOVGT R6, #1
	MOVLT R6, #0
	MOVGT R7, R2
	MOVGT R2, R3
	MOVGT R3, R7
	
	MOV R11, #2
	MUl R7, R3, R11
	SUB R7, R7, R2
	
	MOV R8, #1
	
guardar:
	STRB R0, [R9], #1
	STRB R1, [R9], #1
	
loop:
	CMP R7, #0
	BLT reset_values
	
	CMP R6, #1
	BEQ update_x
	
	ADD R1, R1, R5
	
	MOV R10, #0
	MUL R10, R2, R11
	SUB R7, R7, R10
	
	B loop
	
update_x:
	ADD R0, R0, R4
	BX LR
	
reset_values:
	CMP R6, #1
	BEQ update_y
	
	ADD R0, R0, R4
	
	MOV R10, #0
	
	MUL R10, R3, R11
	
	ADD R7, R7, R10
	
	ADD R8, R8, #1
	
	CMP R8, R0
	BLE guardar
	
	B exit
	
update_y:
	ADD R1, R1, R5
	BX LR
	
exit:
	BX LR
	