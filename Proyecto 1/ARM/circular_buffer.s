.data
buffer: .space 16
start:	.word 0
end:	.word 0
size:	.word 16

.text
.global main
main:
	LDR R0, =buffer
	MOV R1, #0
	MOV R2, #0
	MOV R3, #16
	BL init_buffer
	
	LDR R0, =buffer
	MOV R1, #10
	BL insert_element
	
	LDR R0, =buffer
	BL extract_element
	
	MOV R7, #1
	SWI 0
	
init_buffer:
	MOV R4, R0
	MOV R5, R3
	
init_loop:
	STRB R1, [R4], #1
	SUBS R5, R5, #1
	BNE init_loop
	MOV R6, #0
	MOV R7, #0
	BX LR
	
insert_element:
	LDR R4, =start
	LDR R5, [R4]
	LDR R6, =end
	LDR R7, [R6]
	CMP R5, R7
	BEQ buffer_full
	
	STRB R1, [R0, R7]
	ADD R7, R7, #1
	LDR R4, =size
	LDR R2, [R4]
	AND R7, R7, R2
	STR R7, [R6]
	BX LR
	
buffer_full:
	MOV R0, #0
	BX LR
	
extract_element:
	LDR R4, =start
	LDR R5, [R4]
	LDR R6, =end
	LDR R7, [R6]
	CMP R5, R7
	BEQ buffer_empty
	
	LDRB R1, [R0, R5]
	ADD R5, R5, #1
	LDR R4, =size
	LDR R2, [R4]
	AND R5, R5, R2
	STR R5, [R4]
	BX LR
	
buffer_empty:
	MOV R0, #0
	BX LR