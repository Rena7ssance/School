	.extern main

	.global start
start:
	add $-40,%esp			# leave some room for system call args
	call main

	push %eax
loop:
	call exit
	jmp loop
