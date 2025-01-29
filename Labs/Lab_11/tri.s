.global main
.global getInputs
.extern intSqrt //DO NOT REMOVE


.align 4
.section .data
    a: .word 0
    b: .word 0
// your data here


.align 4
.section .rodata
// your read only data here
    prompt1: .asciz "Enter side #1 of the trianle: "
    prompt2: .asciz "Enter side #2 of the trianle: "
    inPat:  .asciz "%d"
    errMsg: .asciz "Input cannot be less than 1.\n"
    outRes: .asciz "Hypotenuse: %d\n"
    debug:  .asciz "number: %d\n"

.text
main:
    push {lr}

    //Get inputs
    bl getInputs

    //Do the math
    mul r4, r0, r0

    //second sqrt
    mul r5, r1, r1

    //add
    add r0, r4, r5

    //final sqrt
    bl intSqrt
    mov r1, r0

    //Output
    ldr r0, =outRes
    //mov r1, r0
    bl printf

    pop {pc}

getInputs:
    push {lr}

    inputDo1: # {
        //Prompt for input 1
        ldr r0, =prompt1
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =a
        bl scanf

        //Check input
        ldr r4, =a
        ldr r4, [r4]
        cmp r4, #0
        ble inputDo1
    # }

    inputDo2: # {
        //Prompt for input 2
        ldr r0, =prompt2
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =b
        bl scanf

        //Check input
        ldr r5, =b
        ldr r5, [r5]
        cmp r5, #0
        ble inputDo2
    # }

    //Move to r0 and r1 to return
    mov r0, r4
    mov r1, r5

    pop {pc}
