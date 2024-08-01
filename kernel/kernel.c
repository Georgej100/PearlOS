#include "../drivers/VGAtext.h"
#include "../drivers/printf.h"
#include "../CPU/interrupts.h"

#define KERNEL_VERSION 1.0

extern void main()
{			
	
	move_cursor(0, 0);
	kprintf("Welcome to PearlOS V%f\n\0", KERNEL_VERSION);
	
	init_IDT();
	
	volatile int x = 0;	
	int y = x/x;
	y = x/x;	
	y++;
	
	kprintf("TEST\n");
	
	while(1)
	{
		continue;
	}
}
