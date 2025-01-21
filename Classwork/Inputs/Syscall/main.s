.global _start

.section .data
    input: .ascii "Hello World String\n"

.text
_start:

//This whole section is like a scanf("%s")
    //As user for input with syscall
    //3 into r7 to indicate we want to call a read syscall
    mov r7, #3
    //Where its coming from, stdin = 0
    mov r0, #0
    //Send location
    ldr r1, =input //Address of input
    //Size of input
    mov r2, #5
    //call syscall
    swi 0
//End input

    //Output what we recieved
    //Put 4 into r7 to indicate a write syscall
    mov r7, #4
    //Write to stdout aka 1
    mov r0, #1
    //What we want to write
    ldr r1, =input
    //Size of output
    mov r2, #19
    //Call syscall
    swi 0

    //Lastly we exit
    //return 0
    mov r7, #0 //Exit syscall
    //Call syscall
    swi 0
