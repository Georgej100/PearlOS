[org 0x7E00]
bits 16

KERNEL_LOCATION equ 0x8400
KERNEL_SIZE_SECTORS equ 0x39	; BIOS complains after 40 sectors due to the mav limit of sectors per track


jmp bootloader_start


bootloader_start:
	push welcome_msg
	call print
	add sp, 2

	; --TODO--
	; Load kernel - DONE
	; Detect memory
	; Get drive info
	; GDT and protected mode 
	; Jump to kernel
	
	mov ah, 0x02	
	mov al, KERNEL_SIZE_SECTORS	; Sectors to read
	mov ch, 0x00	; Cylinder
	mov cl, 0x05 	; Start sctor
	mov dh, 0x00	; Head
	mov bx, KERNEL_LOCATION
	call read_disk 

	jmp $

welcome_msg: db "Loading Kernel...", 0

%include"boot/disc_utils.s"

times 1536 - ($-$$) db 0
