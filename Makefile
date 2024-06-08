DIRECTORY=~/OS1

build:
	nasm -f bin $(DIRECTORY)/boot/boot.s -o $(DIRECTORY)/tmp/boot.bin
	nasm -f bin $(DIRECTORY)/boot/bootloader.s -o $(DIRECTORY)/tmp/bootloader.bin
	cat $(DIRECTORY)/tmp/boot.bin $(DIRECTORY)/tmp/bootloader.bin $(DIRECTORY)/tmp/60sfiller.bin > $(DIRECTORY)/out/out.bin

run:
	qemu-system-x86_64 -nographic $(DIRECTORY)/out/out.bin
