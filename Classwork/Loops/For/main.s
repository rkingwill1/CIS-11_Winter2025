.global main

.section .data //Initialized data
    input: .word 0

.section .rodata //Readonly data
    outPrmpt: .asciz "Enter a number to sum till: "
    inPat:    .asciz "%d"
    outStr:   .asciz "Your sum is %d\n"
    debug:    .asciz "i = %d\n"

.section .bss //Uninitialized variables

.text
main:
    push {lr}

    //Prompt user
    ldr r0, =outPrmpt
    bl printf
    //Get input
    ldr r0, =inPat
    ldr r1, =input
    bl scanf

    //Loop addition till n
    mov r4, #1 //int i = 1;
    mov r5, #0 //int sum = 0;
    //Load input
    ldr r6, =input
    ldr r6, [r6]

for:
    //for(...; i <= input; ...)
    cmp r4, r6 //if(i > input) exit for loop
    bgt endFor

    //Summation
    add r5, r4 //sum = sum + i;
    
    //Debug output
    ldr r0, =debug
    mov r1, r4   //copy i to r1
    bl printf

    //Increment i as part of loop
    add r4, #1 //i++
    //Branch back to start of loop
    bal for



endFor:
    //Output result
    ldr r0, =outStr
    mov r1, r5
    bl printf

    //return 0
    mov r0, #0
    pop {pc}
