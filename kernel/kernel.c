#include "kernel.h"
#include "../drivers/ps2.h"
#include "../drivers/printf.h"
#include "../CPU/interrupts.h"
#include "../libs/common.h"

#define KERNEL_VERSION 1.1

extern void main()
{			
	
	kprintf("Welcome to PearlOS V%f\n\0", KERNEL_VERSION);
	
	IDT_init();
	ps2_init();	
			
	while(1)
	{
		continue;
	}
}

// PANIC function, only dependency alllowed is kprintf
void kpanic(char* message, struct InterruptRegisters* regs)
{
	kprintf("--KERNEL PANIC--\n");
	kprintf("%s\n", message);
	kprintf("SYSTEM WILL BE HALTED\n");
	kprintf("cr2: %zu, ds: %zu, edi: %zu, esi: %zu, ebp: %zu, ebx: %zu, edx: %zu, ecx: %zu, eax: %zu, \n Interrupt No. %zu, Error code: %zu, eip: %zu", regs->cr2,  regs->ds,  regs->edi, regs->esi, regs->ebp, regs->ebx, regs->edx, regs->ecx, regs->eax, regs->int_no, regs->err_code, regs->eip);
}
