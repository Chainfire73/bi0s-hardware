# Compiling
```
git clone --depth=1 https://github.com/Chainfire73/bi0s-hardware.git
cd bi0s-hardware/04-firmware/assembly/
make       #compile all
make add   #compile just one
```
# Some important things to know

## 1. Memory Segments
A segmented memory model divides the system memory into groups of independent
segments referenced by pointers located in the segment registers. Each segment
is used to contain a specific type of data.

**Data segment** − It is represented by ***.data*** section and the ***.bss***. The .data
section is used to declare the memory region, where data elements are stored
for the program. This section cannot be expanded after the data elements are
declared, and it remains static throughout the program.

The ***.bss*** section is also a static memory section that contains buffers for data
to be declared later in the program. This buffer memory is zero-filled.

**Code segment** − It is represented by .text section. This defines an area in
memory that stores the instruction codes. This is also a fixed area.

**Stack** − This segment contains data values passed to functions and
procedures within the program.

## 2. Some Instructions
Instruction | Operands | Description
---  |    ---   | ---
**cmp**  | S1, S2   | *Set condition codes according to S1-S2*
**test** | S1, S2  | *Set condition codes according to S1&S2*
**call** | Label  | *Push return address to stack and jump to label*
**ret** | | *Pop return address from stack and jump there*
**leave** |  |  *Release the stack frame, equivalent to mov rsp, rbp ; pop rbp*
**enter** |  | *Creates a stack frame. Enter is avoided in practice as it performs quite poorly*
**inc** |S | *Increment by 1*
**dec** |S |*Decrement by 1*
**mov** |S, D |  *Copy the value from source to destination*
**lea** | S, D | *Load effective address of source into destination*

### mov vs lea
```
mov eax, dword [ebp-0x4]; Load value at that address
;NOTE: in the case of mov, the value inside '[]' ("effective address") should be a valid memory address
lea eax, [eax + 0x4]    ; Compute address of value
;NOTE: it doesn't have to be a valid address. lea is often used as a "trick" to do certain computations.
```
- **lea** is  the only instruction that performs memory addressing calculations
  but doesn't actually address memory
- Advantages of **lea** over **add**:
   1. The ability to perform addition with either two or three operands.
   2. The ability to store the result in any register; not just one of the source operands.

### int 80h vs syscall
todo

## Registers
   [64-bit](https://stackoverflow.com/questions/20637569/assembly-registers-in-64-bit-architecture)
## Linux syscalls
   [syscall-table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)

### Writing a Function
A program uses a region of memory called the stack to support function calls. As the name
suggests, this region is organized as a stack data structure with the “top” of the stack growing
towards lower memory addresses. For each function call, new space is created on the stack to
store local variables and other data. This is known as a stack frame. To accomplish this, you will
need to write some code at the beginning and end of each function to create and destroy the
stack frame (see [sec.4.4.2 of this pdf](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf) for more)
## Miscellaneous

### Exit Code
Exit code are the simplest way get some output from your program. To do that, make a exit syscall in the program, then enter this in the same shell after its execution.
```
$ echo $?
```
The shell will replace '$?' with the exit code of previous command

### NASM
#### Get  ASCII value of a char
use backquotes('`'-the key just below escape key) around the character to get its ASCII value
```
eg: `\n`
```
### db vs equ vs resb
todo
### Macros
[watch video](https://www.youtube.com/watch?v=mRTax0MLaok)
## todo
1. add comments for rest of the programs
2. add error handing for sys calls
