.global main
.global randC //Adds a random color to the pattern array

//External functions
.extern initRand
.extern getRand

//Global constants
.equ R, 82
.equ G, 71
.equ B, 66
.equ Y, 89

.section .data //Initialized variables
    colors: .word R, G, B, Y //Colors enum
    size:   .word 0 //Number of colors in pattern

.section .rodata //Readonly data
    debugC: .asciz "Debug: %c\n"
    debugD: .asciz "Debug: %d\n"

.section .bss //Uninitialized data
    .align 4
    pattern: .space 400 //Array for the color pattern (up to 100 colors)

.text
main:
    push {lr}
    //Seed random
    bl initRand

    //Add Random color
    ldr r2, =pattern
    ldr r3, =size
    bl randC

    //Output Pattern
    ldr r0, =pattern
    ldr r1, =size
    ldr r1, [r1]
    bl outArr

    mov r0, #0
    pop {pc}

//r2 = pattern[]
//r3 = &size
randC:
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
