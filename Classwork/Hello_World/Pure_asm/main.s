// Starting keyword
.global _start

// Read only data
.section .rodata

hello: .ascii "Hello World\n"

// Initialized variables
.section .data

// Uninitialized non-constant data
.section .bss

// This is where the code starts
.text

_start:
	
    // Just printf("%s", hello);

    // Put 4 into r7 (syscall register)
    mov r7, #4
    //wite to cout is 1
    //Moving 1 to r0 register
    mov r0, #1
    //load the hello string into the r1 register (stores the address of hello into the ldr)
    ldr r1, =hello
    //store the size of what we are printing
    mov r2, #12
    //Run the system call by doing a sofware interrupt
    swi 0
    
    //To return 0 we need to do a syscall for exit
    //Exit instruction into syscall reg
    mov r7, #1
    //Error code into r0
    mov r0, #0
    //System call to exit
    swi 0
    

