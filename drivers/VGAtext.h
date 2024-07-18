#pragma once

#include <stdint.h>

void write_char(char character, unsigned int forecolour, unsigned int backcolour);
void disable_cursor(void);
void enable_cursor(uint8_t start_scanline, uint8_t end_scanline);
void move_cursor(unsigned int x, unsigned int y);
void move_cursor_raw(uint16_t pos);
uint16_t get_cursor_pos(void);
