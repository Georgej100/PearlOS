GDT_Start:
	GDT_Null:
		dd 0x00
		dd 0x00
	GDT_Code:
		dw 0xFFFF
		dw 0x00
		db 0x00
		db 0b10011010
		db 0b11001111
		db 0x00
	GDT_Data:
		dw 0xFFFF
		dw 0x00
		db 0x00
		db 0b10010010
		db 0b11001111
		db 0x00
GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1
	dd GDT_Start


CODE_SEG equ GDT_Code - GDT_Start
DATA_SEG equ GDT_Data - GDT_Start		
