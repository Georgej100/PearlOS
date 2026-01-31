CC=i386-elf-gcc
LD=i386-elf-ld
ASM=nasm

ASMFLAGS = -f elf
CCFLAGS = \
	-m32 -march=i386 -mtune=i386 \
	-ffreestanding -nostdlib -nostdinc \
	-fno-builtin -fno-stack-protector \
	-fno-pic -fno-pie \
	-fno-omit-frame-pointer \
	-O2 -g \
	-Wall -Wextra -Werror

LDFLAGS = --oformat binary

TMP_DIR := tmp
OUT_DIR := out

DRIVER_C_SRCS := $(wildcard drivers/*.c)
CPU_C_SRCS    := $(wildcard CPU/*.c)
CPU_S_SRCS    := $(wildcard CPU/*.s)
KERNEL_C_SRCS := $(wildcard kernel/*.c) $(wildcard libs/*.c)
KERNEL_S_SRCS := $(wildcard kernel/*.s)

KERNEL_OBJS := \
	$(DRIVER_C_SRCS:%.c=$(TMP_DIR)/%.o) \
	$(CPU_C_SRCS:%.c=$(TMP_DIR)/%.o) \
	$(CPU_S_SRCS:%.s=$(TMP_DIR)/%.o) \
	$(KERNEL_C_SRCS:%.c=$(TMP_DIR)/%.o) \
	$(KERNEL_S_SRCS:%.s=$(TMP_DIR)/%.o)

BOOTSECT = bootsect.bin
KERNEL   = kernel.bin
ISO      = boot.iso

# =======================
# Build rules
# =======================

$(TMP_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "CC  $< -> $@"
	$(CC) -c $< -o $@ $(CCFLAGS)

$(TMP_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	@echo "ASM $< -> $@"
	$(ASM) $(ASMFLAGS) $< -o $@

kernel: $(KERNEL_OBJS)
	@mkdir -p $(OUT_DIR)
	@echo "LD  -> $(OUT_DIR)/$(KERNEL)"
	$(LD) -Ttext 0x8400 -o $(OUT_DIR)/$(KERNEL) $^ $(LDFLAGS)

bootloader:
	@mkdir -p $(TMP_DIR) $(OUT_DIR)
	$(ASM) -f bin boot/boot.s -o $(TMP_DIR)/boot.bin
	$(ASM) -f bin boot/bootloader.s -o $(TMP_DIR)/bootloader.bin
	cat $(TMP_DIR)/boot.bin $(TMP_DIR)/bootloader.bin > $(OUT_DIR)/$(BOOTSECT)

image: kernel bootloader
	cat $(OUT_DIR)/$(BOOTSECT) $(OUT_DIR)/$(KERNEL) > $(OUT_DIR)/out.bin

clean:
	rm -rf $(TMP_DIR) $(OUT_DIR)

docker: clean kernel bootloader image 
