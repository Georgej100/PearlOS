#include"VGAtext.h"
#include<stdint.h>

/*
Writes character to VIDEO_MEMORY at x,y
character is writen followed by colour info byte
*/
void WriteChar(char character, unsigned int x, unsigned int y, unsigned int forecolour, unsigned int backcolour)
{
	unsigned int attribute = (backcolour << 4) | (forecolour & 0x0f);
	volatile uint16_t* where = (volatile uint16_t*)VIDEO_MEMORY + (y * WIDTH + x);
	*where = character | (attribute << 8);
}


/*
Uses WriteChar to write string
Uses a while loop to prevent having to pass length as a parameter
cX anc cY act as a cursor
*/
void WriteString(char* string, unsigned int x, unsigned int y, unsigned int forecolour, unsigned int backcolour)
{
	char* pString = string;
	int cX = x;
	int cY = y;

	while(1)
	{
		WriteChar(*pString, cX, cY, forecolour, backcolour);
		pString++;
/*
		if(cX > WIDTH)
		{
			cX = 0;
			cY++;
		}

		if(cY > HEIGHT)
		{
			cY = 0;
			cX = 0;
		}
*/
		if(*pString == '\0')
		{
			break;
		}
		
		cX++;
	}	
}
