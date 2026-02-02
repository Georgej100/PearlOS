docker:
	nasm boot/boot.s -f bin -o tmp/boot/boot.bin -I boot/
	nasm boot/loader.s -f bin -o tmp/boot/loader.bin 
	cat tmp/boot/boot.bin tmp/boot/loader.bin > out/bootloader.bin
	qemu-system-x86_64 out/bootloader.bin -nographic
