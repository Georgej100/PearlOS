bits 16
[org 0x7e00]

jmp bootloader_start

KERNEL_BASE_LOCATION equ 0x8400
KERNEL_BLOCK_SIZE equ 39		; BIOS can't read over cylinder boundries

bootloader_start:
	push welcome_msg
	call print
	add sp, 2

	; --TODO--
	; Load kernel - DONE
	; Detect memory
	; GDT and protected mode - DONE
	; Jump to kernel - DONE
	
	mov si, KERNEL_PACKET
	call read_disk	
	
	push pm_mode
	call print
	add sp, 2

	mov ah, 0x0
	mov al, 0x3
	int 0x10
	
	lgdt [GDT_Descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	cli
	jmp CODE_SEG:start_pm_mode

welcome_msg: db "Loading Kernel...", 0
pm_mode: db "Entering PM mode...", 0

KERNEL_PACKET:
	db 0x10		; Packet size
	db 0
	dw 23		; Sectors num
	dw KERNEL_BASE_LOCATION		; Location
	dw 0
	dd 4		; LBA
	dd 0


%include"boot/disc_utils.s"
%include"boot/gdt.s"

[bits 32]
start_pm_mode:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ebp, 0x90000
	mov esp, ebp
	jmp KERNEL_BASE_LOCATION


times 1536 - ($-$$) db 0	; Fill the 3 sectors of bootloader with 0
