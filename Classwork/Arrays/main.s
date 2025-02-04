.global main
.global outputArr

.section .data
    arr: .skip 100 //Skip 100bytes (25 x 4bytes)

.section .rodata
    out: .asciz "a[%d] = %d\n"

.section .bss

.text
main:
    push {lr}

    //Load parameters
    ldr r0, =arr
    mov r1, #25
    bl outputArr

    //Load array address again
    ldr r0, =arr
    //Counter
    mov r4, #0

    for: # {
        cmp r4, #25
        bge endFor

        str r4, [r0] //Store i into array address

        //Increment counter
        add r4, #1
        //Increment array index
        add r0, #4 //4bytes

        bal for
    # }
    endFor:

    //Call array output
    ldr r0, =arr
    bl outputArr


    mov r0, #0
    pop {pc}

//r0 = &arr
//r1 = 25
outputArr:
    push {r4, lr}

    //Counter
    mov r4, #0
    //Output loop
    outFor: # {
        //Conditions check
        cmp r4, r1
        bge outForEnd

        //Output
        push {r0-r1}
        ldr r2, [r0] //Address of array
        mov r1, r4
        ldr r0, =out
        bl printf
        pop {r0-r1}


        //Increment counter
        add r4, #1
        //Increment array address
        add r0, #4 //4bytes

        bal outFor

    # }
    outForEnd:



    pop {r4, pc}
