.global main

.section .data //Initialized variables
	a: .word 0 //Integer 1
	b: .word 0 //Integer 2
	c: .word 0 //Integer 3

.section .rodata //Readonly Data
	inPat: .asciz "%d"
	prompt: .asciz "Enter an integer: "
	outStr: .asciz "Largest Integer: %d\n"
	

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
	ldr r1, =a
	ldr r1, [r1] //Dereference a
	ldr r2, =b
	ldr r2, [r2] //Dereference b
	//Compare a and b
	cmp r1, r2
	bgt CmpXC //if(a>b), don't move anything

LessAB: //If a < b
	mov r1, r2 //Put b in r1
	
CmpXC: //Compare either a or b with c
	ldr r2, =c //Put c in r2
	ldr r2, [r2] //Dereference c
	cmp r1, r2 //Compare r1 (a or b) with r2 (c)
	bgt Output

LessXC: //If (either a or b) < c
    mov r1, r2 //Put c into r1 
    
Output:
	//Output result
    ldr r0, =outStr
    bl printf
    
	//return 0
    mov r0, #0
	
	pop {pc}
	