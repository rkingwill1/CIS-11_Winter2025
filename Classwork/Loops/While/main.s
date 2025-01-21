.global main

.section .data //Initilized data
    input: .word 0

.section .rodata
    outPrmpt: .asciz "Enter a number to sum till: "
    inPat:    .asciz "%d"
    outStr:   .asciz "Your sum is %d\n"
    debug:    .asciz "i = %d\n"

.section .bss

.text
main:
    push {lr}

    //Prompt for iput
    ldr r0, =outPrmpt
    bl printf
    //Get input
    ldr r0, =inPat
    ldr r1, =input
    bl scanf

    //Loop addition till number
    mov r4, #1 //int i = 1;
    mov r5, #0 //int sum = 0;
    //Load input
    ldr r6, =input
    ldr r6, [r6]
while:
    //while(i <= input)
    cmp r4, r6
    bgt endWhile //if(i > input) exit while loop

    //Increment sum (r5) by i (r4)
    add r5, r4  //sum = sum + i

    //Debug printf
    ldr r0, =debug
    mov r1, r4
    bl printf

    //Lastly, increment i (r4)
    add r4, #1 //i++

    //Branch back to start of loop
    bal while


endWhile:
    //Output results (sum)
    ldr r0, =outStr
    mov r1, r5      //r5 = sum
    bl printf

    //return 0
    mov r0, #0
    pop {pc}
