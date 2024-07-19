#include "../drivers/VGAtext.h"
#include "../drivers/printf.h"


extern void main()
{		
	enable_cursor(0, 15);
	move_cursor(0, 0);
	char* message = "Hello World!\0";
	printf("%s", message);

	while(1)
	{
		continue;
	}
}
