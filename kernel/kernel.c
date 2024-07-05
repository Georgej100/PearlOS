#include"../drivers/VGAtext.h"

extern void main()
{	
	
	WriteChar('X', 0, 0, 15, 0);
	WriteString("HELLO WORLD\0", 0, 1, 15, 0);
	
	while(1)
	{
		continue;
	}
}
