GDT_Start:
	GDT_Null:
		dd 0x00
		dd 0x00
	GDT_Code:
		dw 0xFFFF	; First 16 bits of limit
		dw 0x00		; First 24 bits of base
		db 0x00		; Above
		db 0b10011010	; Pres, priv, type flags
		db 0b11001111	; Other plus last 4 limit bits
		db 0x00		; Last bits of base
	GDT_Data:
		dw 0xFFFF	; Same as above
		dw 0x00
		db 0x00
		db 0b10010010	; Type flags change
		db 0b11001111
		db 0x00
GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1
	dd GDT_Start


CODE_SEG equ GDT_Code - GDT_Start
DATA_SEG equ GDT_Data - GDT_Start		
