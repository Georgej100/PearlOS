build:
	nasm -f bin ~/OS1/src/boot.s -o ~/OS1/tmp/boot.bin

run:
	qemu-system-x86_64 -nographic ~/OS1/tmp/boot.bin
