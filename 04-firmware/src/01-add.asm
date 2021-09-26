%include "functions.asm"
section .data
	prompt    db "enter a number: "
	promptlen equ $ - prompt
section .bss
	buf resb 1024
section .text
	global _start
_start:
	pop rax
	cmp rax, 3
	jne getinput

getargs:
	pop rdi 	;arg[0]
	pop rdi 	;arg[1]
	CONVTOINT rdi	;convtoint store output in rax
	mov rbx, rax
	pop rdi 	;arg[2]
	CONVTOINT rdi
	jmp add
getinput:
	PRINT STDOUT, prompt, promptlen
	INPUT STDIN, buf, 7
	CONVTOINT buf
	mov rbx, rax

	PRINT STDOUT, prompt, promptlen
	INPUT STDIN, buf, 7
	CONVTOINT buf

add:
	add rax, rbx


	call mkstr
	mov [buf],rdi
	PRINT STDOUT, buf, 8
	PRINTCHAR STDOUT, `\n`

	EXIT 0
