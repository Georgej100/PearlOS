#include "../drivers/VGAtext.h"
#include "../drivers/printf.h"


extern void main()
{		
	enable_cursor(0, 15);
	move_cursor(0, 0);
	char* message = "Hello World!\0";
	printf("%s", message);
	
	char* pointer = message;
	while(*pointer != '\0')
	{
		write_char(*pointer, 15, 0);
		pointer++;
	}	


	while(1)
	{
		continue;
	}
}
