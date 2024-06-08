read_disk:
	push bp
	mov bp, sp
	pusha
	
	mov ah, 0x02
	mov dl, 0x80
	int 0x13

	jc READ_ERROR

	cmp ah, 0x00
	jne READ_ERROR
	
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
