.arch armv7-a
.fpu vfpv3
.eabi_attribute 67, "2.09"	@ Versión EABI
.eabi_attribute 6, 10		@ ABI de punto flotante duro

.section .data

file_path:      .asciz "prueba.txt"
buffer:         .space 2205      @ Tamaño del búfer para contener el contenido del archivo
ejemploFloat:	.float 4.566
constante:	.float 75.0
buffer_addr:	.word 0

.align 1

.section .text

.globl _start

_start:
    @ Abrir el archivo
    ldr r0, =file_path
    mov r1, #2      @ O_RDONLY (Modo de lectura)
    mov r2, #0
    mov r7, #5      @ Código de llamada al sistema para abrir el archivo
    swi 0

    @ Verificar errores al abrir el archivo (r0 contiene el descriptor del archivo o el código de error)
    cmp r0, #-1
    beq error

    @ Almacenar el descriptor del archivo en r9
    mov r9, r0

    @ Puntero al búfer
    ldr r8, =buffer
    @ Contador de bytes leídos
    mov r10, #0

@ Bucle para leer valores del archivo y convertirlos a enteros
read_loop:
    @ Leer un byte del archivo
    mov r0, r9
    ldr r1, =buffer
    mov r2, #1       @ Leer un byte a la vez
    mov r7, #3       @ Código de llamada al sistema para leer desde el archivo
    swi 0

    @ Comprobar si se alcanzó el final del archivo
    cmp r0, #0
    beq pre_calculation

    @ Convertir el byte leído a un entero
    ldrb r3, [r8]    @ Cargar el byte en r3
    sub r3, r3, #'0' @ Convertir ASCII a entero (suponiendo que el byte representa un dígito)

    @ En este punto, r3 contiene el valor entero del byte leído



    @ Incrementar el contador de bytes leídos
    add r10, r10, #1

    b read_loop

pre_calculation:
    @ Imprimir el contenido del búfer en la consola
    mov r0, #1        @ Descriptor de archivo para stdout
    mov r1, r8
    mov r2, r10
    mov r7, #4        @ Código de llamada al sistema para escribir en la consola
    swi 0

exit:
    @ Cerrar el archivo
    mov r0, r9
    mov r7, #6        @ Código de llamada al sistema para cerrar el archivo
    swi 0

    mov r7, #1        @ Código de llamada al sistema para salir del programa
    swi 0

error:
    @ Manejo de errores al abrir el archivo
    mov r0, #1        @ Descriptor de archivo para stderr
    ldr r1, =error_msg
    ldr r2, =error_msg_len
    mov r7, #4        @ Código de llamada al sistema para escribir en la consola
    svc 0
    b exit

error_msg:      .asciz "Error al abrir el archivo.\n"
error_msg_len = . - error_msg
