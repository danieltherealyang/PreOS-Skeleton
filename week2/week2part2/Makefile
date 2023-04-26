ASM=nasm
QEMU=qemu-system-x86_64
ELF=elf64
BUILD_DIR=build

all:
	@mkdir -p $(BUILD_DIR)
	@make build

build:  $(BUILD_DIR)/os-image

$(BUILD_DIR)/os-image: $(BUILD_DIR)/boot-sect.bin $(BUILD_DIR)/kernel.bin
	@cat $^ > $@

$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o
	@ld -o $@ -Ttext 0x1000 $^ --oformat binary

$(BUILD_DIR)/kernel_entry.o : kernel_entry.asm
	@$(ASM) $< -f $(ELF) -o $@

$(BUILD_DIR)/kernel.o : kernel.c
	@gcc -ffreestanding -c $< -o $@

$(BUILD_DIR)/boot-sect.bin: boot-sect.asm 
	@$(ASM) $< -f bin -o $@

run: all
	@$(QEMU) -drive format=raw,file=$(BUILD_DIR)/os-image

clean:
	@rm -r $(BUILD_DIR)
