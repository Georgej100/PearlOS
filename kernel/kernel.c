#include<stdint.h>

extern void main(void)
{	
	*(char*)0xb8000 = 'A';
	*(char*)0xb8000 = 'B';	

	
	while(1)
	{
		continue;
	}
}
