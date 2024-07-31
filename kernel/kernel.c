#include "../drivers/VGAtext.h"
#include "../drivers/printf.h"
#include "../CPU/interrupts.h"

#define KERNEL_VERSION 1.0

// Debug function
int zero();

extern void main()
{			
	
	move_cursor(0, 0);
	kprintf("Welcome to PearlOS V%f\n\0", KERNEL_VERSION);
	
	init_IDT();
	
	int x = 0 / zero();
	x++;
	while(1)
	{
		continue;
	}
}

int zero()
{
	return 0 * 0;
}
