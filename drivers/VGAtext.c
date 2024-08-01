#include <stdint.h>
#include "VGAtext.h"
#include "../libs/common.h"


#define VIDEO_MEMORY 0xb8000
#define WIDTH 80
#define HEIGHT 25

/*
Character is writen followed by colour info byte
*/
void write_char (char character, unsigned int forecolour, unsigned int backcolour)
{
	uint16_t pos = get_cursor_pos_raw();

	// Check if character is newline
	if (character == '\n')
	{
		uint16_t y = (uint16_t)(pos / WIDTH);
		move_cursor(0, (y + 1));
		return;
		
	}
	
	unsigned int attribute = (backcolour << 4) | (forecolour & 0x0f);
	volatile uint16_t* where = (volatile uint16_t*)VIDEO_MEMORY + pos;
	*where = character | (attribute << 8);
	move_cursor_raw(pos + 1);
	return;
}

/*
Moves cursor to x,y
*/
void move_cursor (unsigned int x, unsigned int y)
{
	// Calculate VIDEO MEMORY offset
	uint16_t offset = (y * WIDTH + x);
	move_cursor_raw(offset);	
	return;
}

void move_cursor_raw (uint16_t pos)
{
	// Set x position with top 4 bits
	outb(0x3d4, 0x0f);
	outb(0x3d5, (uint8_t)(pos & 0xFF));

	// Set y position with lower 4 bits
	outb(0x3d4, 0x0e);
	outb(0x3d5, (uint8_t)((pos >> 8) & 0xFF));
	return;
}

/*
Enables the cursor by defining the start and end scanlines
*/
void enable_cursor (uint8_t start_scanline, uint8_t end_scanline)
{
	// Set start scanline
	outb(0x3d4, 0x0a);
	outb(0x3d5, (inb(0x3d5) & 0xc0) | start_scanline);
	
	// Set end scanline
	outb(0x3d4, 0x0b);
	outb(0x3d5, (inb(0x3d5) & 0xe0) | end_scanline);
	return;
}

/*
Disables cursor
*/
void disable_cursor (void)
{
	outb(0x3d4, 0x0a);
	outb(0x3d5, 0x20);
	return;
}


/*
Gets cursor position
Returns (y * width + x)
*/
uint16_t get_cursor_pos_raw (void)
{
	uint16_t pos = 0;
	
	outb(0x3d4, 0x0f);
	pos |= inb(0x3d5);
	outb(0x3d4, 0x0e);
	pos |= ((uint16_t)inb(0x3d5) << 8);

	return pos;
}
