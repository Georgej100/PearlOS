[org 0x7C00]
bits 16

mov ax, 0 ; Set up segments
mov ds, ax
mov ss, ax
mov es, ax

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

mov ah, 0x41
mov bx, 0x55aa
mov dl, 0x80
int 0x13		; Check for INT 0x13 extensions

jc no_extensions	; Error check

mov si, BOOT_PACKET
call read_disk
 

jmp 0x7E00	; Jump to stage 2 bootloader
jmp $

BOOT_PACKET:
	db 0x10		; Size of packet
	db 0
	dw 3		; Number of sectors to read
	dw 0x7e00	; Location
	dw 0
	dd 1		; LBA
	dd 0

no_extensions:
	push no_extensions_msg
	call print
	add sp, 2
	jmp $

%include"boot/disc_utils.s"

no_extensions_msg: db "INT 13 extensions are not supported by your BIOS, hanging...", 0
welcome_msg: db "Loading bootloader...", 0

times 510-($-$$) db 0x0
db 0x55, 0xAA
