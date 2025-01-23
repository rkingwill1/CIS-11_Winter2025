.global main

.section .data
    input: .word 0

.section .rodata
    prmpt: .asciz "Enter a number to multiply by 5: "
    inPat: .asciz "%d"
    outRes: .asciz "%d x 5 = %d\n"

.text
main:
    push {lr}

    //Prompt for input
    ldr r0, =prmpt
    bl printf
    //Get input
    ldr r0, =inPat
    ldr r1, =input
    bl scanf

    //Load values
    ldr r1, =input
    ldr r1, [r1]

    //Math
    //Shift by 2 to multiply by 4, then add the original value to that to make it multiply by 5 instead
    lsl r2, r1, #2 //Multiply by 4
    add r2, r1     //Add by r1 to get multiply by 5

    //Output results
    ldr r0, =outRes
    bl printf

    //return 0
    mov r0, #0
    pop {pc}
