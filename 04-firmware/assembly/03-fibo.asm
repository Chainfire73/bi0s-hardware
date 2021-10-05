%include "functions.asm"
section .data
	prompt      db  "enter a number: "
	promptlen   equ $ - prompt
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
	jmp getfibo

getinput:
	PRINT STDOUT, prompt, promptlen
	INPUT STDIN, buf, 7
	CONVTOINT buf


getfibo:
call fibo
call mkstr
mov [buf], rdi
PRINT STDOUT, buf, 8
PRINTCHAR STDOUT, `\n`
EXIT 0

fibo:
        cmp     rax, 2  ;base case
        ja      recurse ;if n>2
        mov     rax, 1
        ret
recurse:
        push    rsi
        push    rbx
        mov     rbx, rax
        dec     rax
        call    fibo
        mov     rsi, rax
        lea     rax, [rbx-2]
        call    fibo
        add     rax, rsi
        pop     rbx
        pop     rsi
        ret
