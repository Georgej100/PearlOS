[org 0x7C00]
bits 16

mov ax, 0 ; Set up segments
mov ds, ax
mov ss, ax
mov es, ax
mov bx, 0x7E00

mov bp, 0x7c00
mov sp, bp


mov [diskNum], dl

push 0x500
call movecursor ; Set cursor to top left
add sp, 2
call clearscreen
push welcome_msg
call print ; print welcome
add sp, 2

mov ah, 2
mov al, 3	; Sectors to read count
mov ch, 0	; Cylinder
mov dh, 0	; Head
mov cl, 2	;Sector
call read_disk


jmp 0x7E00	; Jump to stage 2 bootloader
jmp $

%include"boot/disc_utils.s"

welcome_msg: db "Loading bootloader...", 0


times 510-($-$$) db 0x0
db 0x55, 0xAA
