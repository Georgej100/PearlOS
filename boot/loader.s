[org 0x7e00]

mov dh, 8
mov cl, 5
mov dl, 0
mov bx, where oh where  
call read_disk 

cli

lgdt [gdt_descriptor]   ; From gdt.s

mov eax, cr0 
or eax, 1   ; Set first bit of CR0 , a control register
mov cr0, eax

jmp CODE_SEG:pm_mode_start

%include "gdt.s"
%include "disk.s"

[bits 32]

pm_mode_start:
    mov ax, DATA_SEG ; Now in PM , our old segments are meaningless ,
    mov ds, ax ; so we point our segment registers to the
    mov ss, ax ; data selector we defined in our GDT
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    mov ebp, 0x9fc00
    mov esp, ebp

    jmp $


times 1536-($-$$) db 0 
