.arch armv7-a
.fpu vfpv3
.eabi_attribute 67, "2.09"	@ Version EABI
.eabi_attribute 6, 10		@ ABI de punto flotante duro

.section .data

file_path:      .asciz "muestras_audio.txt"
buffer:         .space 4500000      @ Tamaño del buffer para contener el contenido del archivo
alpha:  	    .float 0.6
uno:            .float 1.0
constante:	.float 75.0

contador:   .word 0
maximo: .word 2205
buffer_addr:	.word 0
direccion: .space 4500000

.align 1

.section .text

.globl _start

@------------------------------------- LECTURA DEL ARCHVO .TXT -----------------------------------
_start:
    @ Abrir el archivo
    ldr r0, =file_path
    mov r1, #2      @ O_RDONLY (Modo de lectura)
    mov r2, #0
    mov r7, #5      @ Codigo de llamada al sistema para abrir el archivo
    swi 0

    @ Verificar errores al abrir el archivo (r0 contiene el descriptor del archivo o el código de error)
    cmp r0, #-1
    beq error

    
    mov r9, r0 @ Almacenar el descriptor del archivo en r9
    ldr r8, =buffer  @ Puntero al búfer
    mov r10, #0 @ Contador de bytes leídos
    ldr r6, =direccion @inicializar direccion
@----------------------------------------------------------------------------------------------------

@////////////////////// NUMEROS POSITIVOS (CONVERSION Y PARSEO) //////////////////////////
@ Bucle para leer valores del archivo y convertirlos a enteros
read_loop:
    @ Leer un byte del archivo
    mov r0, r9
    ldr r1, =buffer
    mov r2, #1       @ Leer un byte a la vez
    mov r7, #3       @ Código de llamada al sistema para leer desde el archivo
    swi 0

    @ Comprobar si se alcanzo el final del archivo
    cmp r0, #0
    beq exit

    LDR R5, =2205
    @ Convertir el byte leido a un entero
    ldrb r3, [r8]    @ Cargar el byte en r3
    cmp r3, #'-'     @ Comprobar si el siguiente byte es un signo negativo
    beq negative
    
    sub r3, r3, #'0' @ Convertir ASCII a entero (suponiendo que el byte representa un dígito)

    @Comparacion de SALTO DE LINEA
    cmp r3, #-38
    beq store_data


    @OPERACION PARA NUMEROS DE 2 A 3 DIGITOS
    ldr r11, =10
    mul r4, r4, r11    @ Multipilica r4 x10 
    add r4, r3       @ Dato r4 almacenado temporalmente de r3


    @ Incrementar el contador de bytes leídos
    add r10, r10, #1
    b read_loop
@//////////////////////////////////////////////////////////////////////////////////////////


@////////////////////// NUMEROS NEGATIVOS (CONVERSION Y PARSEO) //////////////////////////
negative:
     @ Leer un byte del archivo
    mov r0, r9
    ldr r1, =buffer
    mov r2, #1       @ Leer un byte a la vez
    mov r7, #3       @ Código de llamada al sistema para leer desde el archivo
    swi 0

    @ Comprobar si se alcanzo el final del archivo
    cmp r0, #0
    beq exit

    @ Convertir el byte leido a un entero
    ldrb r3, [r8]    @ Cargar el byte en r3

    @OPERACION PARA NUMEROS DE 2 A 3 DIGITOS
    sub r3, r3, #'0' @ Convertir ASCII a entero (suponiendo que el byte representa un dígito)

    @Comparacion de SALTO DE LINEA
    cmp r3, #-38
    beq store_data_neg

    ldr r11, =10
    mul r4, r4, r11      @ Multipilica r4 x10 
    add r4, r3       @ Dato r4 almacenado temporalmente de r3

    @ Incrementar el contador de bytes leidos
    add r10, r10, #1
    b negative
@////////////////////////////////////////////////////////////////////////////////////////

@------------------- GUARDADO EN MEMORIA DATOS ORIGINALES --------------------
store_data:
    cmp R12,R5
    bgt store_data_2

    LDR R11, =alpha
    VMOV.F32 S5, R4

    VLDR.F32 S1, [R11] @Constante alpha
    LDR  R11, =uno
    VLDR.F32 S4, [R11]
  
    VSUB.F32 S2, S4, S1 @Resta (1-alpha)
    VMUL.F32 S3, S2, S5 @(1-a)*x(n)

    VSTR.F32 S3, [R6]
    ADD R6, R6, #1

    mov r4, #0 @DEBUG i r
    ADD R12, R12, #1

    b read_loop

store_data_2:
    LDR R11, =alpha @0.6
    VMOV.F32 S5,R4 @Pasa a float el dato

    VLDR.F32 S1, [R11] @Constante alpha para utilizar
    LDR R11, =uno @Carga constante uno
    VLDR.F32 S4, [R11] @Cargar uno flotante

    VSUB.F32 S2,S4,S1 @(1-a)
    VMUL.F32 S2,S2,S5 @(1-a) *x(n)


    LDR R3,[R6, #-2205] @Carga el valor de antes
    VMOV.F32 S3,R3
    VMUL.F32 S3,S1,S3 @a*y(n-k)
    VADD.F32 S2,S2,S3 @(1-a)*x(n) +a*y(n-k)
    
    VSTR.F32 S2, [R6]
    ADD R6, R6, #1

    MOV R4,#0 @DEBUG i r
    ADD R12,R12,#1

    b read_loop

store_data_neg:
    cmp R12,R5
    bgt store_data_neg2

    VMOV.F32 S5,R4 
    NEG R4,R4
    VNEG.F32 S5,S5

    LDR R11, =alpha
    
    VLDR.F32 S1, [R11] @Constante alpha
    LDR  R11, =uno
    VLDR.F32 S4, [R11]
  
    VSUB.F32 S2, S4, S1 @Resta (1-alpha)
    VMUL.F32 S3, S2, S5 @(1-a)*x(n)

    VSTR.F32 S3, [R6]
    ADD R6, R6, #1

    mov r4, #0 @DEBUG i r
    ADD R12,R12,#1
    b read_loop


store_data_neg2:
    VMOV.F32 S5,R4 
    NEG R4,R4
    VNEG.F32 S5,S5

    STRB R4, [R6]
    LDR R11, =alpha @0.6
    VMOV.F32 S5,R4 @Pasa a float el dato

    VLDR.F32 S1, [R11] @Constante alpha para utilizar
    LDR R11, =uno @Carga constante uno
    VLDR.F32 S4, [R11] @Cargar uno flotante

    VSUB.F32 S2,S4,S1 @(1-a)
    VMUL.F32 S2,S2,S5 @(1-a) *x(n)

    LDR R3,[R6, #-2205] @Carga el valor de antes
    VMOV.F32 S3,R3
    VMUL.F32 S3,S1,S3 @a*y(n-k)
    VADD.F32 S2,S2,S3 @(1-a)*x(n) +a*y(n-k)
    ADD R6,R6,#1

    VSTR.F32 S3, [R6]
    ADD R6, R6, #1

    MOV R4,#0 @DEBUG i r
    ADD R12,R12,#1


    b read_loop

@-----------------------------------------------------------------------------


@------------------- SALIDA DEL PROGRAMA -------------------------------------
exit:
    @ Cerrar el archivo
    mov r0, r9
    mov r7, #6        @ Codigo de llamada al sistema para cerrar el archivo
    swi 0

    mov r7, #1        @ Codigo de llamada al sistema para salir del programa
    swi 0
@------------------------------------------------------------------------------

@--------------------  MANEJO DE ERRORES -------------------------------------
error:
    @ Manejo de errores al abrir el archivo
    mov r0, #1        @ Descriptor de archivo para stderr
    ldr r1, =error_msg
    ldr r2, =error_msg_len
    mov r7, #4        @ Codigo de llamada al sistema para escribir en la consola
    svc 0
    b exit
@------------------------------------------------------------------------------

error_msg:      .asciz "Error al abrir el archivo.\n"
error_msg_len = . - error_msg
