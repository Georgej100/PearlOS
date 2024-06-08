GDT_Start:
	GDT_Null:
		dd 0x0000
		dd 0x0000
	GDT_Code:
		dw 0xFFFF
		dw 0x0000
		db 0b10011010
		db 0b11001111
		db 0x0000
	GDT_Data:
		dw 0xFFFF
		dw 0x0000
		dw 0x0000
		db 0b10010010
		db 0b11001111
		db 0x0000
GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1
	dd GDT_Start
		
