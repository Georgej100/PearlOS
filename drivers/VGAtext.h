#pragma once
#define VIDEO_MEMORY 0xb8000
#define WIDTH 80
#define HEIGHT 25

 void WriteChar(char character, unsigned int x, unsigned int y, unsigned int forecolour, unsigned int backcolour);
