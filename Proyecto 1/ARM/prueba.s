.data

.balign 1
file_name: .asciz "output.txt"
newline:   .asciz "\n"  @ Carácter de salto de línea

.text

.global _start
_start:
    MOV R7, #8
    LDR R0, =file_name
    MOV R1, #0777
    SWI 0

    MOV R7, #4         @write(int fd, void* buf, int len)
    MOV R1, #123       @buf
    MOV R2, #3         @len
    SWI 0

    MOV R7, #4         @write(int fd, void* buf, int len) para escribir el carácter de salto de línea
    LDR R1, =newline   @buf
    MOV R2, #1         @len (longitud del carácter de salto de línea)
    SWI 0
    
    MOV R7, #6         @close(int fd)
    SWI 0
_end:
    MOV R7, #1
    SWI #0
