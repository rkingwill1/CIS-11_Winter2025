.global main

.section .data
    arr: .word 10, 20, 30, 40, 50

.section .rodata
    outSum:  .asciz "Sum is %d\n"
    outStep: .asciz "%d + %d\n"

.text
main:
    stmdb sp!, {lr}

    ldr r0, =arr //Load array address
    mov r1, #5 //Size
    bl sumArr //Returns sum into r1

    //Print sum
    ldr r0, =outSum
    bl printf


    ldmia sp!, {pc}

sumArr:
    stmdb sp!, {r4-r5, lr}

    //Initialize function variables
    mov r4, #0 //int i = 0;
    mov r5, #0 //int sum = 0;
    for: # {
        cmp r4, r1
        bgt forEnd 

        //Push
        stmdb sp!, {r0, r1}

        //Output step
        ldr r2, [r0]
        mov r1, r5
        ldr r0, =outStep
        bl printf

        //Pop
        ldmia sp!, {r0, r1}

        //Increment array pointer
        ldr r2, [r0], #4 //Load array value into r2, and then increment pointer
        //Math
        add r5, r2

        //Increment counter
        add r4, #1
        
        bal for

    # }
    forEnd:


    ldmia sp!, {r4-r5, pc}
