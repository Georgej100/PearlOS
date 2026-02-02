[org 0x7c00]

mov ah, 0x0e    ; Print char INT
mov al, 65      ; Capital A
int 0x10        ; Call INT

loop:
    inc al          ; Next char
    cmp al, 'Z' + 1 ; Compare if at end
    je exit         ; If at end exit
    int 0x10        ; Print next char
    jmp loop        ; Repeat
exit:
    jmp $   ; Hang


times 510-($-$$) db 0   ; Boot sector filler
db 0x055, 0x0aa         ; Magic
