.global main

//External functions
.extern initRand
.extern getRand

.section .data

.section .rodata
    //Colors that can be in the code
    colors: .word 'R', 'O', 'Y', 'G', 'B', 'P', 'W', 'Z' //Red, Orange, Yellow, Green, Blue, Purple, White, Zlack
    //Strings
    inPat: .asciz "%c %c %c %c"
    prmpt: .asciz "Enter your guess (4 colors R, O, Y, G, B, P, W, Z)\n"
    prmptG: .asciz "Guess %d: "
    outStat: .asciz "%d correct, %d misplaced \n"
    outWin: .asciz "All colors are correct, you win!\n"
    outLose: .asciz "Out of guesses, you lose.\n"
    outElem: .asciz "%c "
    newline: .asciz "\n"
    //Code size
    size: .word 4

.section .bss
    .align 4
    code: .space 16

.text
main:
    push {lr}

    //Seed random
    bl initRand

    //Generate random code
    ldr r0, =colors
    ldr r1, =code
    ldr r2, =size
    ldr r2, [r2]
    bl genCode

    //Output code
    ldr r0, =code
    ldr r1, =size
    ldr r1, [r1]
    bl outArr

    mov r0, #0
    pop {pc}

//r0 = colors[]
//r1 = code[]
//r2 = size
genCode:
    push {r4-r5, lr}

    //Move params to safe registers
    mov r3, r0 //colors[]
    mov r4, r1 //code[]
    mov r5, r2 //size

    mov r2, #0
    gFor: # {
        cmp r2, r5
        bge gfEnd

        //Generate number 0-7
        mov r0, #8
        mov r1, #0
        push {r2-r5}
        bl getRand
        pop {r2-r5}
        //Convert to color
        ldr r0, [r3, r0, lsl #2]

        //Insert into code
        str r0, [r4]

        //Increment counter
        add r2, #1
        //Increment array pointer
        add r4, #4

        bal gFor
    # }
    gfEnd:

    pop {r4-r5, pc}
    

//r0 = arr[]
//r1 = size
outArr:
    push {r4-r6, lr}

    //Load params into safe regs
    mov r5, r0 //arr[]
    mov r6, r1 //size

    mov r4, #0
    oFor: # {
        cmp r4, r6
        bge ofEnd

        ldr r1, [r5]
        ldr r0, =outElem
        bl printf


        //Increment counter
        add r4, #1
        //Increment array index pointer
        add r5, #4

        bal oFor
    # }
    ofEnd:

    ldr r0, =newline
    bl printf


    pop {r4-r6, pc}
