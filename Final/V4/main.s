.global main

//External functions
.extern initRand
.extern getRand

//Global constants


.section .data //Initialized variables
    colors: .word 'R', 'G', 'B', 'Y' //Colors enum
    size:   .word 0 //Number of colors in pattern
    //Temporary for stdin-based version
    input: .word 0

.section .rodata //Readonly data
    debugC: .asciz "Debug: %c\n"
    debugD: .asciz "Debug: %d\n"
    //Temporary for stdin-based version
    prompt: .asciz "Enter color %d: "
    outG: .asciz "Guess elem %d: %d\n"
    inPat: .asciz " %c"
    outLose: .asciz "Game Over :(\n"

.section .bss //Uninitialized data 
    .align 4
    pattern: .space 400 //Array for the color pattern (up to 100 colors)

.text
main:
    push {lr}
    //Seed random
    bl initRand

    mDo: # {
        //Add Random color
        ldr r2, =pattern
        ldr r3, =size
        bl addClr

        //Output Pattern
        ldr r0, =pattern
        ldr r1, =size
        ldr r1, [r1]
        bl outArr

        //Enter Pattern
        ldr r0, =pattern
        ldr r1, =size
        ldr r1, [r1]
        bl guess

        cmp r0, #1
        beq mDo
    # }
    

    mov r0, #0
    pop {pc}

//r2 = pattern[]
//r3 = &size
addClr:
    push {r4, lr}

    //Load size value into r4
    ldr r4, [r3]

    //Random number 0-3
    mov r0, #4
    mov r1, #0
    bl getRand //Returns number in r0

    //Convert number to color
    ldr r1, =colors //Load colors enum
    ldr r0, [r1, r0, lsl #2] //Load color from colors enum/array

    //Add color to pattern
    str r0, [r2, r4, lsl #2] //At index (size * 4)

    //Increment pattern size
    add r4, #1
    str r4, [r3] //Store new size in size variable

    pop {r4, pc}

//r0 = pattern[]
//r1 = size
outArr:
    push {r4-r6, lr}

    //Load params to safe reg
    mov r5, r0
    mov r6, r1


    mov r4, #0
    oWhile: # {
        cmp r4, r6
        bge owEnd

        //Output
        ldr r1, [r5, r4, lsl #2]
        ldr r0, =debugC
        bl printf


        //Increment counter
        add r4, #1

        bal oWhile
    # }
    owEnd:


    pop {r4-r6, pc}

//r0 = pattern[]
//r1 = size
guess:
    push {r4-r7, lr}

    //Move params to safer registers (TEMPORARY)
    mov r5, r0 //pattern[]
    mov r6, r1 //size


    mov r4, #0
    gDoFor: # {
        //Prompt input
        ldr r0, =prompt 
        mov r1, #1 //
        add r1, r4 //i + 1
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =input
        bl scanf

        
        //Check if correct
        ldr r1, =input
        ldr r1, [r1]
        ldr r7, [r5, r4, lsl #2]
        cmp r1, r7 
        bne lose

        //Increment counter
        add r4, #1

        cmp r4, r6
        blt gDoFor
    # }

    win:
        mov r1, #1 //Return correct = true
        pop {r4-r7, pc}

    lose:
        mov r0, #0 //Return correct = false 
        //Lose message
        ldr r0, =outLose
        bl printf 
    

    pop {r4-r7, pc}
