read_disk:
	push bp
	mov bp, sp
	pusha
	
	mov ah, 0x42
	mov dl, 0x80
	int 0x13	; Read using LBA addressing
	
	xor al, al
	mov bx, ax
	call print_dec

	jc READ_ERROR	; Error check
	
	push SUCCESS_MSG
	call print
	add sp, 2

	popa
	mov sp, bp
	pop bp
	ret

%include "boot/print_utils.s"

READ_ERROR:
	push ERROR_MSG
	call print
	add sp, 2
	jmp $
	
SUCCESS_MSG: db "Read from disk successfully", 0
ERROR_MSG: db "Failed to read from disk, hanging...", 0

diskNum: db 0
