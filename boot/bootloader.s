[org 0x7E00]
bits 16

jmp bootloader_start


bootloader_start:
	mov ah, 0x0e
	mov al, 'T'
	int 0x10
	jmp $
