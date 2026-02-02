; dl    = drive #
; dh    = # sectors to read
; cl    = start sector
; ES:BX = destination to read to
read_disk:
    pusha
    push dx     ; For error checking

    mov ah, 0x02    ; Read disk
    mov al, dh      ; Sectors to read
    mov ch, 0       ; Cylinder
    mov dh, 0       ; Head
    mov cl, cl      ; Start sector

    int 0x13

    jc DISK_ERROR     ; Carry flag is set if there is an error

    pop dx ; Restore DX from the stack
    cmp dh , al ; if AL ( sectors read ) != DH ( sectors expected )
    jne DISK_ERROR ; display error message
    
    popa
    ret

DISK_ERROR:
   mov si, DISK_ERROR_MSG
   call print_string
   jmp $


;%include "print.s"

DISK_ERROR_MSG:
    db "Disk Error! Hanging...", 0
    
