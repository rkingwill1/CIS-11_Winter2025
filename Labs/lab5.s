.global main

.section .data //Initialized Variables
    bYear: .word 0 //User's birth year
    year:  .word 0 //Current year

.section .rodata //Readonly Data
    inPat: .asciz "%d"
    prmpt1: .asciz "Enter your birth year: "
    prmpt2: .asciz "Enter the current year: "
    outRslt: .asciz "Your age: %d\n"

.section .bss //Uninitialized Variables

.text
main:
    //Keep track of where I came from
    push {lr}

    //Prompt user to input birth year
    ldr r0, =prmpt1 //Message
    bl printf
    //Get user input
    ldr r0, =inPat
    ldr r1, =bYear
    bl scanf

    //Prompt user to input current year
    ldr r0, =prmpt2
    bl printf
    //Get user input
    ldr r0, =inPat
    ldr r1, =year
    bl scanf

    //Load variables into registers to prep for operations
    ldr r2, =bYear //Load address
    ldr r2, [r2]   //Load value
    ldr r3, =year  //Load address
    ldr r3, [r3]   //Load value

    //Operations
    sub r1, r3, r2 //r1 = r3 - r2

    //Output result
    ldr r0, =outRslt
    bl printf

    //return 0
    mov r0, #0

    //Resume where I left off
    pop {pc}
