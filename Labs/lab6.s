.global main

.section .data //Initialized variables
	a: .word 0
	b: .word 0
	c: .word 0

.section .rodata //Readonly Data
	inPat: .asciz "%d"
	prompt: "Enter an integer: "
	

.section .bss //Uninitialized Variables

.text
main:
	push {lr}

	//Prompt user for input 1
	ldr r0, =prompt
	bl printf
	//Get input 1
	ldr r0, =inPat
	ldr r1, =a
	bl scanf

	//Prompt user for input 2
	ldr r0, =prompt
	bl printf
	//Get input 2
	ldr r0, =inPat
	ldr r1, =b
	bl scanf

	//Prompt user for input 3
	ldr r0, =prompt
	bl printf
	//Get input 3
	ldr r0, =inPat
	ldr r1, =c
	bl scanf


	//Comparisons
	//Load registers with a & b
	ldr r0, a
	ldr r1, b
	//Compare a and b
	cmp r0, r1
	bgt CmpXC

LessAB:
	ldr r0, =b
	
CmpXC:
	ldr r1, =c
	bgt





	pop {pc}

