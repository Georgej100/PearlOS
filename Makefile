DIRECTORY= $(PWD)
CC=i386-elf-gcc
LD=i386-elf-ld
ASM=nasm
ASMFLAGS= -f elf
CCFLAGS= -ffreestanding -m32 -c -Wall -Werror -nostdlib
LDFLAGS= --oformat binary

DRIVER_C_SRCS=$(wildcard drivers/*.c)

KERNEL_C_SRCS=$(wildcard kernel/*.c) $(wildcard libs/*.c)
KERNEL_S_SRCS=$(wildcard kernel/*.s)
KERNEL_OBJS=$(KERNEL_C_SRCS:.c=.o) $(KERNEL_S_SRCS:.s=.o) $(DRIVER_C_SRCS:.c=.o) 

BOOTSECT=bootsect.bin
KERNEL=kernel.bin
ISO=boot.iso

%.o: %.c
	$(CC) -o $@ -c $< $(CCFLAGS)

%.o: %.s
	$(ASM) -o $@ $< $(ASMFLAGS)

kernel: $(KERNEL_OBJS)
	$(LD) -o ./out/$(KERNEL) -Ttext 0x8400  $^ $(LDFLAGS) 
	
bootloader:
	$(ASM) -f bin ./boot/boot.s -o ./tmp/boot.bin
	$(ASM) -f bin ./boot/bootloader.s -o ./tmp/bootloader.bin
	cat ./tmp/boot.bin ./tmp/bootloader.bin > ./out/$(BOOTSECT)

image:
	cat ./out/$(BOOTSECT) ./out/$(KERNEL)  ./filler.bin > ./out/out.bin

dev: bootloader kernel image

clean: 
	rm ./**/*.o
	rm ./**/*.bin


run:
	qemu-system-x86_64 -display curses -drive format=raw,file=./out/out.bin


