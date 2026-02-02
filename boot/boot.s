[org 0x7c00]

cli
xor ax, ax  ; All segements 0 so offsets go 0:address
mov ds, ax
mov es, ax
mov ss, ax
mov bp, 0x7c00  ; Stack grows down
mov sp, bp
sti

mov byte [BOOT_DISK], dl
push dx

mov si, HELLOWLRD  ; Hello World
call print_string

mov dl, [BOOT_DISK]
mov dh, 3           ; Amount to read
mov cl, 2           ; 1 sector after the boot sector, so 2
mov bx, 0x7e00      ; Directly after boot sector

call read_disk 

jmp bx 

%include "print.s"
%include "disk.s"

HELLOWLRD:
    db "Hello World!", 0

BOOT_DISK: db 0

times 510-($-$$) db 0   ; Boot sector filler
dw 0xaa55

