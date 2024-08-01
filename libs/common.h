#pragma once
#include <stdint.h>

uint8_t inb (uint16_t port);
void outb (unsigned short port, unsigned char val);

void memset(void* mem, char data, int count);

struct InterruptRegisters
{
	uint32_t cr2;
	uint32_t ds;
	uint32_t edi, esi, ebp, ebx, edx, ecx, eax;
	uint32_t int_no, err_code;
	uint32_t eip, csm, eflags, useresp, ss;
}; 
