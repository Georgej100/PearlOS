docker:
	nasm boot/boot.s -f bin -o boot/boot.bin
	qemu-system-x86_64 boot/boot.bin -nographic

