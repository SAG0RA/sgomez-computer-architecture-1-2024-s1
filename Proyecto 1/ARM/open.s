.global _start

.section .data
filename: .asciz "prueba.txt"
filename_addr: .word filename
success_msg: .asciz "Se abrió el archivo correctamente.\n"
error_msg: .asciz "Error al abrir el archivo.\n"

.section .bss
file_descriptor: .skip 4

.section .text
_start:
    // Carga la dirección de la cadena filename en r1
    ldr r1, =filename_addr

    // Llamada al sistema para abrir el archivo
    mov r0, r1          // Carga la dirección de filename en r0
    mov r2, #2          // Modo de apertura (lectura y escritura)
    mov r7, #5          // Número de la llamada al sistema "open"
    svc #0              // Llamada al sistema

    // Verificar si la llamada al sistema fue exitosa
    cmp r0, #0
    blt error_open      // Si r0 < 0, hubo un error al abrir el archivo

    // Si la apertura del archivo fue exitosa, imprimir mensaje de éxito
    mov r0, #1          // Descriptor de archivo estándar (salida estándar)
    ldr r1, =success_msg
    mov r2, #27         // Longitud del mensaje de éxito
    mov r7, #4          // Número de la llamada al sistema "write"
    svc #0              // Llamada al sistema
    b end_program

error_open:
    // Si hubo un error al abrir el archivo, imprimir mensaje de error
    mov r0, #1          // Descriptor de archivo estándar (salida estándar)
    ldr r1, =error_msg
    mov r2, #23         // Longitud del mensaje de error
    mov r7, #4          // Número de la llamada al sistema "write"
    svc #0              // Llamada al sistema

end_program:
    // Salir del programa
    mov r7, #1          // Número de la llamada al sistema "exit"
    svc #0              // Llamada al sistema
