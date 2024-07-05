#include"VGAtext.h"
#include<stdint.h>

void WriteChar(char character, unsigned int x, unsigned int y, unsigned int forecolour, unsigned int backcolour)
{
	unsigned int attribute = (backcolour << 4) | (forecolour & 0x0f);
	volatile uint16_t* where = (volatile uint16_t*)VIDEO_MEMORY + (y * WIDTH + x);
	*where = character | (attribute << 8);
}

void WriteString(char* string, unsigned int x, unsigned int y, unsigned int forecolour, unsigned int backcolour)
{
	
}
