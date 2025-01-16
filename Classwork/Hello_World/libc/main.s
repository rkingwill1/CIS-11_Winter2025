.global main //main entry point since using c to compile this

.section .data //Variable, init
.section .rodata //Read only
	//char* h = "Hello, World!\n";
	hello: .asciz "Hello world\n"
	//since printg needs the format and the parameters I need to store the format
	format: .asciz "%s"

.section .bss //Variable, non-init

.text
main: 
	//Pushing onto a stack for temporary memory storage
	push {lr} //This is where I came from. I need to return to this when I finish
	
	//load the parameters of printf
	//Put the format into the 1st parameter spot, r0
	//Need to use load
	ldr r0, =format
	//Load the sttring we are printing
	ldr r1, =hello
	//Run printf
	//Run functions with branching Branch w/ Link
	bl printf
	
	//Return 0
	mov r0, #0
	//Take off a value from the stack and put into a register I need to use to pop
	pop {pc}
