%include "functions.asm"
section .data
	prompt    db "enter a number: "	;*^[1]
	promptlen equ $ - prompt	;*^[2]
section .bss
	buf resb 1024                   ;a static buffer
section .text
	global _start   ;must be declared for linker

_start:			;entry point, execution starts here
	pop rax		;argc - argument count(integer)
	cmp rax, 3
	jne getinput	;if argument_count != 3 get user input
;get command line arguments
getargs:
	pop rdi 	;arg[0] - pointer to filename(string)
	pop rdi 	;arg[1] - pointer to user arg1(string)
	;convert string pointed rdi to integer
	CONVTOINT rdi	;convtoint store output in rax
	mov rbx, rax	;save rax in rbx
	pop rdi 	;arg[2] - pointer to user arg2(string)
	;convert string pointed rdi to integer
	CONVTOINT rdi
	jmp add         ; unconditional jump
;get user input
getinput:
	PRINT STDOUT, prompt, promptlen ;ask user for input
	INPUT STDIN, buf, 7		;get user input
	;convert string pointed buf to integer
	CONVTOINT buf
	mov rbx, rax			;save rax in rbx

	;ask for second input
	PRINT STDOUT, prompt, promptlen ;ask user for input
	INPUT STDIN, buf, 7		;get user input
	;convert string pointed buf to integer
	CONVTOINT buf

add:
	;at this point rax and rbx has our input as integers
	add rax, rbx
	;now rax has our sum

	;int to string conversion
	call mkstr	;mkstr stores output in rdi
	mov [buf],rdi	;we can't directly print from a
			;register, so mov to buffer

	;print output
	PRINT STDOUT, buf, 8
	PRINTCHAR STDOUT, `\n`

	EXIT 0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[1] you may notice that the string is not null terminated, it okay as our
;print function uses the string length to know the end of the string
;
;[2] '$' refers to the current address of the assembler, ie. the address where
;the next instruction/data would be assembled. So "$ - prompt" is the length of
;the string, 16 in this case
;
;we are using the buffer without erasing its previous contents, won't that be a
;problem if our 2nd input is smaller than 1st one?
;no, because the strings read by the read syscall are null terminated CONVTOINT
;stops when the null byte is reached
;what about our output?
;since this works only for positive numbers, the length of output >= to the
;length of inputs so everything gets overwritten.
