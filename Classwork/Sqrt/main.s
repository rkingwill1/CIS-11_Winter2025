//Global functions
.global main
.global getInput
.global abs
.global isqrt

//External functions
.extern divMod

.section .data
    input: .word 0

.section .rodata
    prompt: .asciz "Enter a number to approximate the square root: "
    inPat:  .asciz "%d"
    debug: .asciz "Guess #%d: %d\n"
    outRes: .asciz "The approx sqrt of %d is %d\n"


.text
main:
    push {lr}

    //Get input
    bl getInput //Input is in r0

    //Load input into r4 for safety
    mov r4, r0
    //Do math
    bl isqrt //Returns guess in r0
    mov r2, r0 //move guess into r2

    //Output results
    ldr r0, =outRes
    mov r3, r4
    bl printf

    mov r0, #0
    pop {pc}

getInput:
    push {r4-r8, lr}

    inputDo: # {
        //Prompt for input
        ldr r0, =prompt
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =input
        bl scanf

        //Load input into r0 to be returned
        ldr r0, =input
        ldr r0, [r0]

        //Loop back if input is bad
        cmp r0, #0
        ble inputDo
    # }


    pop {r4-r8, pc}

isqrt:
    push {lr}

    //r4 = input
    //r5 = guess
    //r6 = prev
    //r7 = t
    //r8 = i
    mov r4, r0 //Move r0 into r4
    lsr r5, r4, #1 //Shift r4 to right by 1 and put in r5

    //Counter variable int i = 0;
    mov r8, #0

    isqrtDo: # {
        //Copy guess into previous guess
        mov r6, r5 

        //Divide input by guess
            //r0 is numberator
            //r1 is denominator
        mov r0, r4
        mov r1, r5 
        bl divMod //Divides input by guess, returns dividend in r0, mod result in r1
        mov r7, r0

        //t = guess + t
        add r7, r5

        //Divide by 2
        lsr r7, #1 //t = t >> 1;
        mov r5, r7

        //Debug print
        ldr r0, =debug
        mov r1, r8
        mov r2, r5
        bl printf

        //Increment counter
        add r8, #1 //i++

        //While loop check
        sub r0, r5, r6
        //run abs on contract r0
        bl abs
        //Check if abs(guess - prev) > 0
        cmp r0, #0
        bgt isqrtDo

        # }

    //Return guess
    mov r0, r5 //Mov guess into r0 (return register)

    pop {pc}

abs:
    push {lr}

    cmp r0, #0
    bge absEnd
    rsb r0, r0, #0 //r0 = 0 - r0

    absEnd:
    
    //return r0 (already has result in r0)


    pop {pc}
