.global main

.section .data


.section .rodata
    prompt: .asciz "Enter a number: "
    outRes: .asciz "= %d\n"
    inPat: .asciz "%d"

.text
main:
    push {lr}

    //Print the prompt
    ldr r0, =prompt
    bl printf
    //Get input
    ldr r0, =inPat
    sub sp, #4 //Make space on stack
    mov r1, sp //Store in stack
    bl scanf

    //Load values
    pop {r0}
    mov r1, #3

    //sdiv (signed division)
    sdiv r1, r0, r1

    //Print result
    ldr r0, =outRes
    bl printf

    mov r0, #0
    pop {pc}

//Compile with gcc main.s -mcpu=cortex-a7
