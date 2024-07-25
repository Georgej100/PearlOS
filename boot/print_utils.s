print:
	push bp
	mov bp, sp
	pusha
	mov si, [bp+4]
	mov bh, 0x00
	mov bl, 0x00
	mov ah, 0x0E
.char:	
	mov al, [si]
	add si, 1
	or al, 0
	je .return
	int 0x10
	jmp .char
.return:
	mov al, 0x0D
	int 0x10
	mov al, 0x0A
	int 0x10

	popa
	mov sp, bp
	pop bp
	ret

clearscreen:
	push bp
	mov bp, sp
	pusha

	mov ah, 0x06
	int 0x10

	popa
	mov sp, bp
	pop bp
	ret

movecursor:
	push bp
	mov bp, sp
	pusha
	
	mov dx, [bp+4]
	mov ah, 0x02
	mov bh, 0x00
	int 0x10

	popa
	mov sp, bp
	pop bp
	ret

print_dec:
	mov dx, 0x00
	mov ax, bx
	mov bx, 10000
	div bx

	mov ah, 0x00
	call print_digit
	mov bx, dx
	
	mov dx, 0x00
	mov ax, bx
	mov bx, 1000
	div bx
	
	mov ah, 0x00
	call print_digit
	mov bx, dx
	
	mov dx, 0x00
	mov ax, bx
	mov bx, 100
	div bx

	mov ah, 0x00
	call print_digit
	mov bx, dx

	mov dx, 0x00
	mov ax, bx
	mov bx, 10
	div bx
	mov ah, 0x00
	call print_digit
	
	mov ax, dx
	mov ah, 0x00
	call print_digit
	ret
	
print_digit:
	mov ah, 0x0E
	add al, 48
	int 0x10
	ret
