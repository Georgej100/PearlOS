#include "stdint.h"
#include "common.h"

void outb (unsigned short port, unsigned char val)
{
	asm volatile("outb %0, %1" : : "a"(val), "Nd"(port) );
}

uint8_t inb (uint16_t port)
{
    uint8_t ret;
	asm volatile ( "inb %1, %0" : "=a" ( ret ) : "dN" ( port ) );
	return ret;
}

void memset(void* mem, char data, int count)
{
	char* block = (char*)mem;
	for(int x = 0; x < count; x++)
	{
		*block = data;
		block++;
	}
}
