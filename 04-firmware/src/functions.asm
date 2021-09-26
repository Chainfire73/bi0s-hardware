STDIN   equ 0
STDOUT  equ 1
STDERR  equ 2

%macro EXIT 1
	mov rdi, %1
	mov rax, 60
	syscall
%endmacro

%macro PRINT 3
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	call write
%endmacro

%macro INPUT 3
	mov rdi, %1
	mov rsi, %2
	mov rdx, %3
	call read
%endmacro

%macro CONVTOINT 1
	mov rdi, %1
	xor rax, rax
	call _convtoint
%endmacro

%macro PRINTCHAR 2
	mov byte[buf], %2
	PRINT %1, buf, 1
%endmacro

section .text

write:
	mov rax, 1
	syscall
	ret

read:
	mov rax, 0
	syscall
	ret

;int to string
;https://codereview.stackexchange.com/questions/142842/integer-to-ascii-algorithm-x86-assembly
mkstr:
	mov ebx, 0xCCCCCCCD
    	xor rdi, rdi

loop:
	mov ecx, eax                    ; save original number
	mul ebx                         ; divide by 10 using agner fog's 'magic number'
	shr edx, 3                      ;

	mov eax, edx                    ; store quotient for next loop

	lea edx, [edx*4 + edx]          ; multiply by 10
	shl rdi, 8                      ; make room for byte
	lea edx, [edx*2 - '0']          ; finish *10 and convert to ascii
	sub ecx, edx                    ; subtract from original number to get remainder

	lea rdi, [rdi + rcx]            ; store next byte

	test eax, eax
	jnz loop
	ret

_convtoint:
    movzx rsi, byte [rdi]   ; Get the current character
    test rsi, rsi           ; Check for \0
    je done
    cmp rsi, 10
    je done

    cmp rsi, 48             ; Anything less than 0 is invalid
    jl error

    cmp rsi, 57             ; Anything greater than 9 is invalid
    jg error

    sub rsi, 48             ; Convert from ASCII to decimal
    imul rax, 10            ; Multiply total by 10
    add rax, rsi            ; Add current digit to total

    inc rdi                 ; Get the address of the next character
    jmp _convtoint
error:
	EXIT 1
done:
    ret                     ; Return total or error code
