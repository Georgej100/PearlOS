FROM i386-elf-gcc:latest

RUN apt update -y
RUN apt install qemu-system -y
RUN apt install nasm -y

WORKDIR /pearlos

CMD ["make", "docker"]
