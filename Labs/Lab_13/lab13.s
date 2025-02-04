.global main
.global celsius

//External function
.extern divmod

.section .data
    outLabels: .asciz "F\tC\n"
    outRes:    .asciz "%d \t%d\n"

.section .rodata
    

.text
main:
    push {lr}

    //Print table labels
    ldr r0, =outLabels
    bl printf

    //Counter variable
    mov r4, #32

    mainFor: # {
        //For condition check
        cmp r4, #100
        bgt forEnd

        //Load counter/farenheit variable
        mov r0, r4
        bl celsius //Returns result in r2

        //Print results
        ldr r0, =outRes
        mov r1, r4
        bl printf

        //Increment counter/farenheit
        add r4, #1

        //Branch back
        
        bal mainFor


    # }
    forEnd:


    mov r0, #0
    pop {pc}


celsius:
    push {lr}

    //MATH
    sub r0, #32
    mov r3, #5
    mul r0, r3
    mov r1, #9
    //Divide
    bl divmod

    //Move quotient to r1 for convience
    mov r2, r0


    pop {pc}
