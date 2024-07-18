#include"../drivers/VGAtext.h"

extern void main()
{		
	enable_cursor(0, 15);
	move_cursor(0, 0);
	for(int x = 0; x < 200; x++)
	{
		write_char('X', 15, 0);
	}

	while(1)
	{
		continue;
	}
}
