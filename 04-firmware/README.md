# crackme

1. ## challenge1

	- I've seen a similar challenge on youtube, so solving this was easy.

	![](./challenge1.png)

2. ## challenge2

	- I knew I had to dissassemble the binary to solve the challenge, used
	  r2 for this, it took some time to get it to show this flowchart (see
	  screenshot).
	- the program basically checks for two things
	   * length of the string is 10
	   * character at index 4 is '@'(40h)

	![](challenge2.png)
	![](./challenge2a.png)

# microcorruption

1. New Orleans
	- check_password function checks the input with the string stored at a
	  particular address (2400h), checking that address in the memory dump
	  reveals the password.
2. Sydney
   	- The lock is controlled by a 16-bit MCU. check_passwd function checks
	  the input with four cmp instructions, checking two bytes at a time.
	  The order of the bytes in the immediate should be reversed (as it is a
	  little endian system) to get the password.

# assembly

I did the programs in x86 64-bit assembly, with functions for I/O in a separate
file

Fibonacci was the hardest one. I tried to do it with recursion, but the program
always ended in a segfault. After some googling found some useful material and
got the program working.

   * section 4.4.1 and 4.4.2 from [this document](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)
   * [compiler explorer](https://godbolt.org/z/dGqqec8a1)
