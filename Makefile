DIRECTORY= $(PWD)
CC=i386-elf-gcc
LD=i386-elf-ld
CFLAGS = -ffreestanding -m32 -g -c 

all: final

run:
	qemu-system-x86_64 -display curses $(DIRECTORY)/out/out.bin

$(DIRECTORY)/tmp/VGAtext.o: $(DIRECTORY)/drivers/VGAtext.c
	$(CC) $(CFLAGS) $(DIRECTORY)/drivers/VGAtext.c -o $(DIRECTORY)/tmp/VGAtext.o

$(DIRECTORY)/tmp/kernel.o: $(DIRECTORY)/kernel/kernel.c
	$(CC) $(CFLAGS) $(DIRECTORY)/kernel/kernel.c -o $(DIRECTORY)/tmp/kernel.o

$(DIRECTORY)/tmp/kernel_entry.o: $(DIRECTORY)/kernel/kernel_entry.s
	nasm  $(DIRECTORY)/kernel/kernel_entry.s -f elf -o $(DIRECTORY)/tmp/kernel_entry.o

$(DIRECTORY)/out/kernel.bin: $(DIRECTORY)/tmp/kernel_entry.o $(DIRECTORY)/tmp/kernel.o $(DIRECTORY)/tmp/VGAtext.o 
	$(LD) -o $(DIRECTORY)/out/kernel.bin -Ttext 0x1000 $(DIRECTORY)/tmp/kernel_entry.o $(DIRECTORY)/tmp/kernel.o $(DIRECTORY)/tmp/VGAtext.o --oformat binary
	

$(DIRECTORY)/tmp/boot.bin: $(DIRECTORY)/boot/boot.s
	nasm -f  bin $(DIRECTORY)/boot/boot.s -o $(DIRECTORY)/tmp/boot.bin 

$(DIRECTORY)/tmp/bootloader.bin: $(DIRECTORY)/boot/bootloader.s
	nasm -f  bin $(DIRECTORY)/boot/bootloader.s -o $(DIRECTORY)/tmp/bootloader.bin

final: $(DIRECTORY)/out/kernel.bin $(DIRECTORY)/tmp/boot.bin $(DIRECTORY)/tmp/bootloader.bin
	cat $(DIRECTORY)/tmp/boot.bin $(DIRECTORY)/tmp/bootloader.bin $(DIRECTORY)/out/kernel.bin $(DIRECTORY)/tmp/60sfiller.bin > $(DIRECTORY)/out/out.bin

