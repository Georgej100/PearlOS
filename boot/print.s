print_string:
    pusha
    jmp print_str
print_str:
    mov ah, 0x0e    ; TTY mode
    mov bh, 0x00
    mov al, [si]    ; Get char
    cmp al, 0       ; Check if end string
    je exit         ; Hang if finished
    int 0x10        ; Print char
    inc si          ; Get next char
    jmp print_str   ; Repeat

exit:
    popa
    ret


