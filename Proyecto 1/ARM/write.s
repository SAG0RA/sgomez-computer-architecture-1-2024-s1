.section .data

file_path:      .asciz "prueba.txt"
buffer:         .space 1024      @ Tamaño del buffer para contener el contenido del archivo

.section .text

.globl _start

_start:
    @ Abre el archivo
    ldr r0, =file_path
    mov r1, #0      @ O_RDONLY (Modo de lectura)
    mov r7, #5      @ Código de llamada al sistema para abrir el archivo
    svc 0

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
    ldr r2, =1024    @ Lee hasta 1024 bytes a la vez
    mov r7, #3       @ Código de llamada al sistema para leer desde el archivo
    svc 0

    @ Verifica si se llegó al final del archivo (EOF)
    cmp r0, #0
    beq preCalculo

    @ Incrementa el contador de bytes leídos
    add r10, r10, r0

    b loop

preCalculo:
    @ Imprime el contenido del buffer en la consola
    mov r0, #1        @ Descriptor de archivo stdout
    mov r1, r8
    mov r2, r10
    mov r7, #4        @ Código de llamada al sistema para escribir en la consola
    svc 0

    @ Cierra el archivo
    mov r0, r9
    mov r7, #6        @ Código de llamada al sistema para cerrar el archivo
    svc 0

exit:
    mov r7, #1        @ Código de llamada al sistema para salir del programa
    svc 0

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
