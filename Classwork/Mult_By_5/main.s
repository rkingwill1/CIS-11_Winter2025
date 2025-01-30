.global main
.global multBy5
.global getInput
.global output

.section .data
    input: .word 0

.section .rodata
    prompt: .asciz "Enter a number: "
    inPat:  .asciz "%d"
    outRes: .asciz "%d x 5 = %d\n"

.text
main:
    push {lr}

    //Get input
    bl getInput //Puts input in r0
    //Move input into r4
    mov r4, r0

    //Load parameter
    mov r0, r4
    //Mult by 5
    bl multBy5  //Puts result in r0

    //Load parameters for output
    mov r1, r0 //Move answer to r1
    mov r0, r4 //Move input to r0
    //Output results
    bl output
    
    //return 0
    mov r0, #0
    pop {pc}

getInput:
    push {lr}

    //Prompt for input 
    ldr r0, =prompt
    bl printf

    ldr r0, =inPat
    ldr r1, =input
    bl scanf

    //Load input value into r0 to return
    ldr r0, =input
    ldr r0, [r0]

    pop {pc}

multBy5:
    push {lr}

    //ALL the math
    //Adds input with itself, then shifts to the left by 2
    add r0, r0, r0, lsl #2

    //Resutl is already in r0
    //return r0
    pop {pc}

output:
    push {lr}

    //Print results
    mov r2, r1 //Result -> r1
    mov r1, r0 //Input -> r1
    ldr r0, =outRes
    bl printf


    pop {pc}

