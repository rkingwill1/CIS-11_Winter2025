.global main

.extern initRand
.extern getRand

.section .rodata
    out1: .asciz "-----Before sorting-----\n"
    out2: .asciz "-----Sorted array-----\n"
    outNum: .asciz "%d "
    newline: .asciz "\n"

.section .data
    len: .word 5

.section .bss
    arr: .space 20 //5 4byte numbers

.text
main:
    stmdb sp!, {lr}

    //Seed random
    bl initRand

    //Get inputs
    ldr r0, =arr
    ldr r1, =len
    ldr r1, [r1]
    bl input

    //Output label
    ldr r0, =out1
    bl printf
    //Output array
    ldr r0, =arr
    ldr r1, =len
    ldr r1, [r1]
    bl outArr

    //Sort
    ldr r0, =arr
    ldr r1, =len
    ldr r1, [r1]
    bl bubbleSort

    //Output label
    ldr r0, =out2
    bl printf
    //Output array
    ldr r0, =arr
    ldr r1, =len
    ldr r1, [r1]
    bl outArr
    


    ldmia sp!, {pc}

input:
    stmdb sp!, {r4-r6, lr}

    //Load registers to safer ones
    mov r5, r0
    mov r6, r1

    mov r4, #0
    iWhile: # {
        cmp r4, r6
        bge iwEnd

        mov r0, #90
        mov r1, #10
        bl getRand

        //Store to array
        str r0, [r5, r4, lsl #2] //r5 + (r4 * 4)

        add r4, #1


        bal iWhile

    # }
    iwEnd:

    ldmia sp!, {r4-r6, pc}

outArr:
    stmdb sp!, {r4-r6, lr}
    
    //Load registers
    mov r5, r0
    mov r6, r1

    //Counter
    mov r4, #0
    oWhile: # {
        cmp r4, r6
        bge owEnd

        //Output
        ldr r1, [r5], #4
        ldr r0, =outNum
        bl printf

        //Increment
        add r4, #1


        bal oWhile
    # }
    owEnd:

    push {r0-r2}
    ldr r0, =newline
    bl printf
    pop {r0-r2}

    ldmia sp!, {r4-r6, pc}

bubbleSort:
    stmdb sp!, {lr}

    sub r1, #1 //int x = i - 1;
    mov r2, #0 //int i = 0;
    bsFor1: # {
        cmp r2, r1
        bge bsf1End

        mov r3, #0
        bsFor2: # {
            cmp r3, r1
            bge bsf2End

            //Load values
            add r4, r0, r3, lsl #2 //offset address
            ldr r5, [r4] //Value at offsetted address

            //Load a[j+1]
            add r6, r3, #1 //j + 1
            add r6, r0, r6, lsl #2 //a + (j + 1) * 4 //Address
            ldr r7, [r6] //Value

            //Now test these values
            cmp r5, r7
            ble noSwap

            //YES SWAP
            str r7, [r4] //Put value in r7 //a[j] = a[j + 1];
            str r5, [r6] //a[j-1]



            noSwap:


            //Increment counter
            add r3, #1

            bal bsFor2

        # }
        bsf2End:

        //Increment counter
        add r2, #1

        bal bsFor1
    # }
    bsf1End:


    ldmia sp!, {pc}
