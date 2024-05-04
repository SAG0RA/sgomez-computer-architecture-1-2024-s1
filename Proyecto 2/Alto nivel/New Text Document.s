start:
STR R4, [R10]
CMP R10, R1
MOV R3, #0
MOV R0, R10

B prueba


neg:
NEG R4, R11

prueba:
STR R4, [R10]
LDR R5, [R9]