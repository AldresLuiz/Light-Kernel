ASM = nasm
C_COMPILER = x86_64-elf-gcc
LINKER = x86_64-elf-ld

asm_source_files = $(shell find src -name *.asm)
asm_object_files = $(patsubst src/%.asm, build/%.o, $(asm_source_files))

c_source_files = $(shell find src -name *.c)
c_object_files = $(patsubst src/%.c, build/%.o, $(c_source_files))

object_files = $(asm_object_files) $(c_object_files)

$(asm_object_files): build/%.o : src/%.asm
	mkdir -p $(dir $@) && \
	$(ASM) -f elf64 $(patsubst build/%.o, src/%.asm, $@) -o $@

$(c_object_files): build/%.o : src/%.c
	mkdir -p $(dir $@) && \
	$(C_COMPILER) -c -I src/headers -ffreestanding $(patsubst build/%.o, src/%.c, $@) -o $@

.PHONY: build
build: $(object_files)
	mkdir -p target/boot
	mkdir -p out
	$(LINKER) -n -o target/boot/kernel.bin -T linker.ld $(object_files) && \
	grub-mkrescue /usr/lib/grub/i386-pc -o out/kernel.iso target

clean:
	rm -rf build out
	rm -f target/boot/kernel.bin

run:
	qemu-system-x86_64 -cdrom out/kernel.iso