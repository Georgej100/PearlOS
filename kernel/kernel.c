#include "../drivers/VGAtext.h"
#include "../drivers/printf.h"


extern void main()
{			
	
	move_cursor(0, 0);
	kprintf("HELLO WORLD!\0");	

	while(1)
	{
		continue;
	}
}
