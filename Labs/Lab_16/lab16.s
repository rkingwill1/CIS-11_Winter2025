.global main

//Extenal function
.extern initRand
.extern getRand

.section .data
    input: .word 0

.section .rodata
    prompt: .asciz "Enter a number to search for: "
    inPat:  .asciz "%d"
    outElem: .asciz "arr[%d] = %d\n"
    outFnd: .asciz "%d was found at index %d\n"
    outNot: .asciz "%d was not found in the array.\n"
    size: .word 25

.section .bss
    .align 4
    arr: .space 100 //25 4byte numbers

.text
main:
    push {lr}

    //Seed random
    bl initRand

    //Fill the array
    ldr r0, =arr
    ldr r1, =size
    ldr r1, [r1]
    bl fillArr

    //Output array
    ldr r0, =arr
    ldr r1, =size
    ldr r1, [r1]
    bl outArr

    //Get number to search
    ldr r0, =prompt
    bl printf
    ldr r0, =inPat
    ldr r1, =input
    bl scanf

    //Search array
    ldr r0, =arr
    ldr r1, =size
    ldr r1, [r1]
    ldr r2, =input
    ldr r2, [r2]
    bl search

    //Output results
    cmp r0, #-1
    movne r2, r0 //Load index if found
    ldrne r0, =outFnd
    ldreq r0, =outNot
    ldr r1, =input //Always load input
    ldr r1, [r1]
    bl printf
    


    mov r0, #0
    pop {pc}

//r0 = arr[]
//r1 = size
fillArr:
    push {r5-r6, lr}

    //Load params into safe regs
    mov r5, r0
    mov r6, r1

    mov r3, #0
    fFor: # {
        cmp r3, r6
        bge ffEnd

        //Generate random number
        mov r0, #90
        mov r1, #10
        bl getRand

        //Store into array
        str r0, [r5]


        //Increment counter
        add r3, #1
        //Increment array index pointer
        add r5, #4

        bal fFor
    # }
    ffEnd:

    pop {r5-r6, pc}

//r0 = arr[]
//r1 = size
outArr:
    push {r4-r6, lr}

    //Load params into safe regs
    mov r5, r0
    mov r6, r1

    mov r4, #0
    oFor: # {
        cmp r4, r6
        bge ofEnd

        mov r1, r4
        ldr r2, [r5]
        ldr r0, =outElem
        bl printf


        //Increment counter
        add r4, #1
        //Increment array index pointer
        add r5, #4

        bal oFor
    # }
    ofEnd:


    pop {r4-r6, pc}

//r0 = arr[]
//r1 = size
//r2 = input
search:
    push {r4, lr}

    mov r4, #0
    sFor: # {
        cmp r4, r1
        bge notFound

        //Load array element value
        ldr r3, [r0]

        //Compare values
        cmp r2, r3
        beq found



        //Increment counter
        add r4, #1
        //Increment array pointer
        add r0, #4

        bal sFor
    # }

found:
    //Return index element is located
    mov r0, r4

    pop {r4, pc}


notFound:
    //Return -1 (not found)
    mov r0, #-1

    pop {r4, pc}
