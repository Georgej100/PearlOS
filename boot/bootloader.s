[org 0x7E00]
bits 16

jmp bootloader_start

KERNEL_LOCATION equ 0x8400
KERNEL_SIZE_SECTORS equ 0x15	; BIOS complains after 40 sectors due to the mav limit of sectors per track
CODE_SEG equ GDT_Code - GDT_Start
DATA_SEG equ GDT_Data - GDT_Start


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

	;cli
	lgdt [GDT_Descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEG:start_pm_mode

	jmp $

[bits 32]
start_pm_mode:
	mov al, 'A'
	mov ah, 0x0f
	mov [0xb800], ax
	jmp $

welcome_msg: db "Loading Kernel...", 0

%include"boot/disc_utils.s"
%include"boot/gdt.s"

times 1536 - ($-$$) db 0	; Fill the 3 sectors of bootloader with 0
