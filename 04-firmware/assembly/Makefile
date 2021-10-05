all: prime add fibo
prime:
	nasm -f elf64 02-prime.asm && ld -m elf_x86_64 02-prime.o -o 02-prime
add:
	nasm -f elf64 01-add.asm && ld -m elf_x86_64 01-add.o -o 01-add
fibo:
	nasm -f elf64 03-fibo.asm && ld -m elf_x86_64 03-fibo.o -o 03-fibo
