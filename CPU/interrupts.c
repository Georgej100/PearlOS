#include <stdint.h>

#include "../drivers/printf.h"
#include "interrupts.h"
#include "../libs/common.h"

extern void IDT_flush(uint32_t);

struct IDT_entry IDT[256];
struct IDTptr IDTR;

void init_IDT(void)
{
	// Sets up IDT pointer
	IDTR.base = (uint32_t) &IDT;
	IDTR.limit = (sizeof(struct IDT_entry) * 256) - 1;
	
	// Clear IDT
	memset(&IDT, 0, sizeof(struct IDT_entry) * 256);
	
	// PIC
	init_PIC();	
	
	// Set ISRs
	set_IDT_entry(0, (uint32_t)isr0,0x00, 0x8E);
    set_IDT_entry(1, (uint32_t)isr1,0x00, 0x8E);
    set_IDT_entry(2, (uint32_t)isr2,0x00, 0x8E);
    set_IDT_entry(3, (uint32_t)isr3,0x00, 0x8E);
    set_IDT_entry(4, (uint32_t)isr4, 0x00, 0x8E);
    set_IDT_entry(5, (uint32_t)isr5, 0x00, 0x8E);
    set_IDT_entry(6, (uint32_t)isr6, 0x00, 0x8E);
    set_IDT_entry(7, (uint32_t)isr7, 0x00, 0x8E);
    set_IDT_entry(8, (uint32_t)isr8, 0x00, 0x8E);
    set_IDT_entry(9, (uint32_t)isr9, 0x00, 0x8E);
    set_IDT_entry(10, (uint32_t)isr10, 0x00, 0x8E);
    set_IDT_entry(11, (uint32_t)isr11, 0x00, 0x8E);
    set_IDT_entry(12, (uint32_t)isr12, 0x00, 0x8E);
    set_IDT_entry(13, (uint32_t)isr13, 0x00, 0x8E);
    set_IDT_entry(14, (uint32_t)isr14, 0x00, 0x8E);
    set_IDT_entry(15, (uint32_t)isr15, 0x00, 0x8E);
    set_IDT_entry(16, (uint32_t)isr16, 0x00, 0x8E);
    set_IDT_entry(17, (uint32_t)isr17, 0x00, 0x8E);
    set_IDT_entry(18, (uint32_t)isr18, 0x00, 0x8E);
    set_IDT_entry(19, (uint32_t)isr19, 0x00, 0x8E);
    set_IDT_entry(20, (uint32_t)isr20, 0x00, 0x8E);
    set_IDT_entry(21, (uint32_t)isr21, 0x00, 0x8E);
    set_IDT_entry(22, (uint32_t)isr22, 0x00, 0x8E);
    set_IDT_entry(23, (uint32_t)isr23, 0x00, 0x8E);
    set_IDT_entry(24, (uint32_t)isr24, 0x00, 0x8E);
    set_IDT_entry(25, (uint32_t)isr25, 0x00, 0x8E);
    set_IDT_entry(26, (uint32_t)isr26, 0x00, 0x8E);
    set_IDT_entry(27, (uint32_t)isr27, 0x00, 0x8E);
    set_IDT_entry(28, (uint32_t)isr28, 0x00, 0x8E);
    set_IDT_entry(29, (uint32_t)isr29, 0x00, 0x8E);
    set_IDT_entry(30, (uint32_t)isr30, 0x00, 0x8E);
    set_IDT_entry(31, (uint32_t)isr31, 0x00, 0x8E);
	
	set_IDT_entry(128, (uint32_t)isr128, 0x00, 0x8E); //System calls
    set_IDT_entry(177, (uint32_t)isr177, 0x00, 0x8E); //System calls

	IDT_flush((uint32_t) &IDTR);
	
	return;
}

void set_IDT_entry(uint8_t index, uint32_t base, uint16_t selector, uint8_t flags)
{
	IDT[index].base_low = base & 0xFFFF;
	IDT[index].base_high = (base >> 16) & 0xFFFF;
	IDT[index].selector = selector;
	IDT[index].zero = 0;
	IDT[index].attributes = flags | 0x60;

	return;

}

void init_PIC(void)
{ 
	// MASTER CHIP @ 0x20 commands and 0x21 data
	// SLAVE CHIP @ 0xA0 commands and 0xA1 data
	// SLAVE CHIP is connected to master on IRQ 2 line

	outb(0x20, 0x11);
	outb(0xA0, 0x11);

	outb(0x21, 0x20);
	outb(0xA1, 0x28);

	outb(0x21, 0x04);
	outb(0xA1, 0x02);

	outb(0x21, 0x01);
	outb(0xA1, 0x01);

	outb(0x21, 0x0);
	outb(0xA1, 0x0);

	return;
}

char* exception_messages[] = {
    "Division By Zero",
    "Debug",
    "Non Maskable Interrupt",
    "Breakpoint",
    "Into Detected Overflow",
    "Out of Bounds",
    "Invalid Opcode",
    "No Coprocessor",
    "Double fault",
    "Coprocessor Segment Overrun",
    "Bad TSS",
    "Segment not present",
    "Stack fault",
    "General protection fault",
    "Page fault",
    "Unknown Interrupt",
    "Coprocessor Fault",
    "Alignment Fault",
    "Machine Check", 
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved"
};

void isr_handler(struct InterruptRegisters* regs)
{
	if(regs->int_no < 32)
	{
		char* msg = "";
		sprintf(msg, "Exception caught: %s\nHalting system", exception_messages[regs->int_no]);
		kprintf(msg);
	}		
}

