#include"VGAtext.h"
#include<stdint.h>

#define VIDEO_MEMORY (char*)0xb8000
#define WIDTH 80
#define HEIGHT 25

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
	char* pointer = string;
	int xOffset = 0;
	int yOffset = 0;
	while(*pointer != '\0')
	{
		WriteChar(*pointer, x + xOffset, y + yOffset, forecolour, backcolour);
		pointer++;
		xOffset++;
	}
}
