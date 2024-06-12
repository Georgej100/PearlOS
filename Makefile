DIRECTORY=~/OS1
CC=i386-elf-gcc
LD=i386-elf-ld

build:
	$(CC) -ffreestanding -m32 -g -c $(DIRECTORY)/kernel/kernel.c -o $(DIRECTORY)/tmp/kernel.o
	nasm $(DIRECTORY)/kernel/kernel_entry.s -f elf -o $(DIRECTORY)/tmp/kernel_entry.o
	$(LD) -o $(DIRECTORY)/out/kernel.bin -Ttext 0x1000 $(DIRECTORY)/tmp/kernel_entry.o $(DIRECTORY)/tmp/kernel.o --oformat binary
	nasm -f  bin $(DIRECTORY)/boot/boot.s -o $(DIRECTORY)/tmp/boot.bin 
	nasm -f  bin $(DIRECTORY)/boot/bootloader.s -o $(DIRECTORY)/tmp/bootloader.bin
	cat $(DIRECTORY)/tmp/boot.bin $(DIRECTORY)/tmp/bootloader.bin $(DIRECTORY)/out/kernel.bin $(DIRECTORY)/tmp/60sfiller.bin > $(DIRECTORY)/out/out.bin

run:
	qemu-system-x86_64 -display curses $(DIRECTORY)/out/out.bin
