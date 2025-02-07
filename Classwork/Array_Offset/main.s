.global main

.section .bss
    arr: .space 20 //5 4byte numbers
    total: .space 4

.section .rodata
    prompt: .asciz "Enter numbers for summing\n"
    outRes: .asciz "The sum is %d\n"
    outIn:  .asciz "Enter number %d: "
    inPat:  .asciz "%d"

.section .data
    len: .word 5

.text
main:
    push {lr}

    //Prompt
    ldr r0, =prompt
    bl printf

    //Load parameters
    ldr r0, =arr
    ldr r1, =len
    ldr r1, [r1]
    bl input

    ldr r0, =arr
    ldr r1, =len
    ldr r1, [r1]
    bl sum //Returns sum into r0

    //Store the sum into total
    ldr r1, =total
    str r0, [r1]

    //Output sum
    ldr r0, =outRes  //r1 is total
    ldr r1, [r1]
    bl printf


    pop {pc}

sum:
    stmdb sp!, {r4, lr}

    //Initialize function variables
    mov r2, #0 //int sum = 0;
    mov r3, #0 //int i = 0;

    //Sum elements
    sWhile: # {
        cmp r3, r1
        bge swEnd

        //Load allow for [address, offest, shift]
        ldr r4, [r0, r3, lsl #2] //a + (i * 4)
        add r2, r4

        //Increment counter
        add r3, #1


        bal sWhile

    # }
    swEnd:

    ldmia sp!, {r4, pc}

input:
    stmdb sp!, {lr}

    //counter
    mov r2, #0
    iWhile: # {
        cmp r2, r1
        bge iwEnd

        //Push values
        stmdb sp!, {r0-r2}
        //Prompt for input
        ldr r0, =outIn
        mov r1, r2
        bl printf

        ldmia sp!, {r0-r2}
        //Get input
        stmdb sp!, {r0-r2} 
        add r1, r0, r2, lsl #2
        ldr r0, =inPat
        bl scanf
        ldmia sp!, {r0-r2}

        //Increment counter
        add r2, #1


        bal iWhile    
    # }
    iwEnd:


    ldmia sp!, {pc}
