#include"../drivers/VGAtext.h"

extern void main()
{		
	
	WriteString("Hello World\0", 0, 0, 15, 0);
	WriteChar('X', 0, 1, 15, 0);

	while(1)
	{
		continue;
	}
}
