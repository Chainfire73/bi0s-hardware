%include "functions.asm"
section .data
	prompt      db  "enter a number: "
	promptlen   equ $ - prompt
	notprime    db  "not prime",`\n`
	notprimelen equ $ - notprime
	isprime     db "is prime",`\n`
	isprimelen  equ $ - isprime
section .bss
	buf resb 1024
section .text
	global _start
_start:
	pop rax
	cmp rax, 2
	jne getinput

getargs:
	pop rdi 	;arg[0]
	pop rdi 	;arg[1]
	CONVTOINT rdi	;convtoint store output in rax
	jmp testprime
getinput:
	PRINT STDOUT, prompt, promptlen
	INPUT STDIN, buf, 7
	CONVTOINT buf


testprime:
	cmp rdi, 1
	je _notprime
	mov rdi, rax
	mov rbx, rdi

testloop:
	dec rbx
	cmp rbx, 2
	je  _isprime
	xor rdx, rdx
	div rbx
	test rdx, rdx
	jz _notprime
	mov rax, rdi
	jmp testloop

_isprime:
	PRINT STDOUT,isprime,isprimelen
	PRINTCHAR STDOUT, `\n`
	jmp exit
_notprime:
	PRINT STDOUT,notprime,notprimelen
	PRINTCHAR STDOUT, `\n`
exit:
	EXIT 0
