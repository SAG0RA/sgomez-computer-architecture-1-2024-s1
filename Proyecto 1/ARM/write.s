.arch armv7-a
.fpu vfpv3
.eabi_attribute 67, "2.09"	@ EABI version
.eabi_attribute 6, 10		@ Hard float ABI

.section .data

file_path:      .asciz "prueba.txt"
buffer:         .space 2205      @ Tamaño del buffer para contener el contenido del archivo
ejemploFloat:	.float 4.566
constante:	.float 75.0
buffer_addr:	.word 0

.align 1

.section .text

.globl _start

_start:
    @ Abre el archivo
    ldr r0, =file_path
    mov r1, #2      @ O_RDONLY (Modo de lectura)
    mov r2, #0
    mov r7, #5      @ Código de llamada al sistema para abrir el archivo
    swi 0

    @ Verifica si hubo un error al abrir el archivo (r0 contiene el descriptor de archivo o el código de error)
    cmp r0, #-1
    beq error

    @ Almacena el descriptor de archivo en r9
    mov r9, r0

    @ Puntero de buffer
    ldr r8, =buffer
    @ Contador de bytes leídos
    mov r10, #0

@ Loop para ir leyendo valores del txt y guardarlos en el buffer
loop:
    @ Lee un bloque de datos del archivo
    mov r0, r9
    ldr r1, =buffer
    ldr r2, =2205    @ Lee hasta 1024 bytes a la vez
    mov r7, #3       @ Código de llamada al sistema para leer desde el archivo
    swi 0

    @ Verifica si se llegó al final del archivo (EOF)
    cmp r0, #0
    beq preCalculo

    @ Incrementa el contador de bytes leídos
    add r10, r10, r0

    b loop

preCalculo:

    @ Se obtiene la direccion del buffer
    str r5, [r8]
    mov r0, #1
    ldr r1, =buffer_addr
    ldr r1, [r1]
    mov r2, #10
    mov r7, #4
    swi 0

    @ Imprime el contenido del buffer en la consola
    @mov r0, #1        @ Descriptor de archivo stdout
    @mov r1, r8
    @mov r2, r10
    @mov r7, #4        @ Código de llamada al sistema para escribir en la consola
    @swi 0

exit:

    @ Cierra el archivo
    mov r0, r9
    mov r7, #6        @ Código de llamada al sistema para cerrar el archivo
    swi 0

    mov r7, #1        @ Código de llamada al sistema para salir del programa
    swi 0

error:
    @ Manejo de error al abrir el archivo
    mov r0, #1        @ Descriptor de archivo stderr
    ldr r1, =error_msg
    ldr r2, =error_msg_len
    mov r7, #4        @ Código de llamada al sistema para escribir en la consola
    svc 0
    b exit

error_msg:      .asciz "Error al abrir el archivo.\n"
error_msg_len = . - error_msg
