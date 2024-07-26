#include "../drivers/VGAtext.h"
#include "../drivers/printf.h"

#define KERNEL_VERSION 1.0

extern void main()
{			
	
	move_cursor(0, 0);
	kprintf("Welcome to PearlOS V%f\n\0", KERNEL_VERSION);
	
	while(1)
	{
		continue;
	}
}
