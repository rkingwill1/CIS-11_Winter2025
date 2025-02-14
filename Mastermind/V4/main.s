.global main

//External functions
.extern initRand
.extern getRand

.section .data
    //Predetermined Code
    code: .word 'R', 'O', 'Y', 'Y'

.section .rodata
    //Colors that can be in the code
    colors: .word 'R', 'O', 'Y', 'G', 'B', 'P', 'W', 'Z' //Red, Orange, Yellow, Green, Blue, Purple, White, Zlack
    //Strings
    inPat: .asciz " %c"
    prmpt1: .asciz "-----Mastermind Codebreaker Game-----\n"
    prmpt2: .asciz "Enter your guess (4 colors R, O, Y, G, B, P, W, Z)\n\n"
    prmptG: .asciz "Guess %d: "
    outRes: .asciz "%d correct, %d misplaced\n\n"
    outWin: .asciz "\n~~~~~All colors are correct, you win!~~~~~\n\n"
    outLose: .asciz "\n-----Out of guesses, you lose.-----\n\n"
    outRand: .asciz "Code has been randomized, game starting over\n"
    //Code size
    size: .word 4    

.section .bss
    guess: .space 16 //Player's guess
    temp: .space 16  //Temporary storage for copy of code

.text
main:
    push {lr}

    //Seed random
    bl initRand

    //Prompt user with introduction
    ldr r0, =prmpt1
    bl printf
    ldr r0, =prmpt2
    bl printf

    //Game loop (10 guesses)
    mov r4, #0
    mFor: # {
        cmp r4, #10
        bge mfEnd

        //Get user's guess
        ldr r0, =guess
        ldr r1, =size
        ldr r1, [r1]
        add r2, r4, #1
        bl getGuess

        //Check if first input is "rand" to create a random code
        cmp r4, #0
        beq rand
        norand:

        //Check guess
        ldr r0, =code
        ldr r1, =size
        ldr r1, [r1]
        ldr r2, =guess
        ldr r3, =temp
        bl check

        //Check if guess is correct
        cmp r0, #4
        beq win

        //Output results
        mov r2, r1
        mov r1, r0
        ldr r0, =outRes
        bl printf

        //Increment counter
        add r4, #1

        bal mFor
    # }
    mfEnd:

    lose:
    ldr r0, =outLose
    bl printf
    bal end

    rand:
    //Check if input is guess is "rand"
    ldr r0, =guess
    ldr r1, [r0] //guess[0]
    cmp r1, #'r'
    bne norand
    ldr r1, [r0, #4] //guess[1]
    cmp r1, #'a'
    bne norand
    ldr r1, [r0, #8] //guess[1]
    cmp r1, #'n'
    bne norand
    ldr r1, [r0, #12] //guess[1]
    cmp r1, #'d'
    bne norand

    //Generate random code
    ldr r0, =colors
    ldr r1, =code
    ldr r2, =size
    ldr r2, [r2]
    bl genCode
    //Notify player code has been randomized
    ldr r0, =outRand
    bl printf
    //Start game over with new code
    mov r4, #0
    bal mFor

    win:
    ldr r0, =outWin
    bl printf
    
    end:
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

//r0 = guess[]
//r1 = size
//r2 = nGuess
getGuess:
    push {r4-r6, lr}

    //Move params to safe registers
    mov r5, r0 //guess[]
    mov r6, r1 //size

    //Prompt User to enter their guess
    ldr r0, =prmptG
    mov r1, r2
    bl printf

    //Get all four color inputs
    mov r4, #0
    ggFor: # {
        cmp r4, r6
        bge ggfEnd

        //Get input
        ldr r0, =inPat
        mov r1, r5
        bl scanf

        //Increment counter
        add r4, #1
        //Increment array pointer
        add r5, #4

        bal ggFor
    # }
    ggfEnd:

    pop {r4-r6, pc}

//r0 = code[]
//r1 = size
//r2 = guess[]
//r3 = temp[]
check:
    push {r4-r9, lr}

    //Move params to safe registers
    mov r4, r0 //code[]
    mov r5, r1 //size
    mov r6, r2 //guess[]
    mov r7, r3 //temp[]

    //Function Variables
    mov r0, #0 //nCrct --- Number of correct colors
    mov r1, #0 //nMsplcd --- Number of misplaced colors
    
    //-----Copy code over to temp-----//
    mov r2, #0 //int i = 0;
    cCopy: # {
        cmp r2, r5
        bge ccEnd

        //Load code[i] value
        ldr r3, [r4, r2, lsl #2]
        //Store code[i] into temp[i]
        str r3, [r7, r2, lsl #2]

        //Increment counter
        add r2, #1

        bal cCopy
    # }
    ccEnd:

    //-----Check for correct colors-----//
    mov r2, #0 //int i = 0
    crctFor: # {
        cmp r2, r5
        bge cfEnd

        //Mark correct if code[i] == guess[i]
        ldr r8, [r7] //temp value
        ldr r9, [r6] //guess value
        cmp r8, r9
        bne incorrect //Skip if not equal

        correct:
        //Increment nCrct
        add r0, #1
        //Replace temp[i] and guess[i] with dummy values
        mov r8, #'X'    //temp
        str r8, [r7]
        mov r9, #'X'    //guess
        str r9, [r6]
        
        incorrect:
        //Increment counter
        add r2, #1
        //Increment array pointers
        add r6, #4
        add r7, #4

        bal crctFor
    # }
    cfEnd:

    //Return to base index of arrays
    sub r6, #16
    sub r7, #16

    //-----Check for misplaced Colors-----//
    mov r2, #0 //int i = 0
    msFor1: # {
        cmp r2, r5
        bge msf1End

        //Make sure temp[i] wasn't already marked correct/misplaced
        ldr r8, [r7, r2, lsl #2]
        cmp r8, #'X'
        beq msf2End

        //Loop through guess to find misplaced temp[i] color
        mov r3, #0 //int j = 0
        msFor2: # {
            cmp r3, r5
            bge msf2End

            //Make sure guess[j] wasn't already marked correct/misplaced
            ldr r9, [r6, r3, lsl #2]
            cmp r9, #'X'
            beq skip
            //Check if temp[i] == guess[j]
            cmp r8, r9
            bne skip

            misplaced:
            //Increment nMsplcd
            add r1, #1
            //Mark guess[j] and temp[i] with dummy var
            mov r8, #'X'    //Temp
            str r8, [r7, r2, lsl #2]
            mov r9, #'X'    //Guess
            str r9, [r6, r3, lsl #2]

            skip:

            @ push {r0-r3}
            @ ldr r0, =debug
            @ mov r1, r8
            @ bl printf
            @ ldr r0, =debug
            @ mov r1, r9
            @ bl printf
            @ pop {r0-r3}

            //Increment counter
            add r3, #1

            bal msFor2
        # }
        msf2End:


        //Increment counter
        add r2, #1

        bal msFor1
    # }
    msf1End:

    pop {r4-r9, pc}
