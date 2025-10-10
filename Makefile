FILES = ./build/kernel.asm.o ./build/kernel.o
FLAGS = -g -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc

hello:
	nasm -f bin ./src/hello.asm -o ./bin/hello.bin

all:
	# Assemble bootloader
	nasm -f bin ./src/boot.asm -o ./bin/boot.bin

	# Assemble and compile kernel
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o
	i686-elf-gcc -I./src $(FLAGS) -std=gnu99 -c ./src/kernel.c -o ./build/kernel.o

	# Combine kernel object files
	i686-elf-ld -g -relocatable $(FILES) -o ./build/completeKernel.o

	# Link into an ELF kernel image
	i686-elf-ld -T ./src/linkerScript.ld -o ./bin/kernel.elf ./build/completeKernel.o

	# Convert ELF → flat binary for bootloader
	i686-elf-objcopy -O binary ./bin/kernel.elf ./bin/kernel.bin

	# Combine bootloader + kernel into final OS image
	cat ./bin/boot.bin ./bin/kernel.bin > ./bin/os.bin
	dd if=/dev/zero bs=512 count=8 >> ./bin/os.bin

clean:
	rm -f ./bin/boot.bin
	rm -f ./bin/hello.bin
	rm -f ./bin/kernel.bin
	rm -f ./bin/os.bin
	rm -f ./build/kernel.asm.o
	rm -f ./build/kernel.o
	rm -f ./build/completeKernel.o

