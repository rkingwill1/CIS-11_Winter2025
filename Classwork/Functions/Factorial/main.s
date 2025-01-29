.global main
.global factorial

.section .data //Initialized data
    n: .word 0

.section .rodata //Readonly data
    prompt: .asciz "Enter a number from 1-12: "
    inPat: .asciz "%d"
    outRes: .asciz "The factorial is %d\n"

.section .bss //Uninitialized data

.text
main:
    push {lr}

    mainDo: # {
        //Prompt for input
        ldr r0, =prompt
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =n
        bl scanf

        //Load register
        ldr r0, =n
        ldr r0, [r0]
        //Check input
        cmp r0, #0
        blt mainDo
        cmp r0, #12
        bgt mainDo
    
    # }

    bl factorial

    mov r1, r0
    //Output
    ldr r0, =outRes
    bl printf

    //return 0
    mov r0, #0
    pop {pc}


factorial: # {
    push {lr}

    //Test if n == 0
    cmp r0, #0
    beq factorialBaseCase

    //t = n - 1
    push {r0} //Keep r0(n)
    sub r0, #1
    bl factorial

    //return n * t
    pop {r1} //Put n from stack into r1
    mul r0, r1
    bal factorialExit

    factorialBaseCase:
        //return 1
        mov r0, #1

    factorialExit:
        pop {pc}

# }
