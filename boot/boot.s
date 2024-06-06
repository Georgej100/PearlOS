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

push 0x0000
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
mov dl, [diskNum]	; Disk number
int 0x13

jmp 0x7E00	; Jump to stage 2 bootloader
jmp $

clearscreen:
	push bp
	mov bp, sp
	pusha

	mov ah, 0x07 ; Set parameters
	mov al, 0x00
	mov bh, 0x07
	mov cx, 0x00
	mov dh, 0x18
	mov dl, 0x4F
	int 0x10 ; Call video services interupt
	
	

	popa
	mov sp, bp
	pop bp
	ret

movecursor: ; Set cursor postion to top stack value
	push bp
	mov bp, sp
	pusha

	mov dx, [bp+4] ; Gets position
	mov ah, 0x02
	mov bh, 0x00 ; Parameters
	int 0x10

	popa
	mov sp, bp
	pop bp
	ret



print: ; Prints top most value of stack (0 terminated)
	push bp
	mov bp, sp
	pusha
	
	mov si, [bp+4] ; Stores message to SI
	mov bh, 0x00
	mov bl, 0x00
	mov ah, 0x0E ; Sets up parameters
.char:
	mov al, [si] ; Copy current char
	inc si ; Get next char
	or al, 0 ; Check if NUL
	je .return
	int 0x10 ; Print
	jmp .char
.return:
	popa
	mov sp, bp
	pop bp
	ret

spin:
	jmp spin


diskNum: db 0
welcome_msg: db "Loading bootloader...", 0



times 510-($-$$) db 0x0
db 0x55, 0xAA
