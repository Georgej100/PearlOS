#include"VGAtext.h"
#include<stdint.h>

#define VIDEO_MEMORY 0xb8000
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

