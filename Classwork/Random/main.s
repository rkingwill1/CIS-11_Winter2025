.global main
.extern divmod

.section .data
    out: .asciz "%d\n"

.text
main:
    push {lr}

    //Seed random
    mov r0, #0
    bl time
    bl srand

    //Counter
    mov r4, #0

    while: # {
        cmp r4, #10
        bge whileEnd

        bl rand
        //Remove chances of getting negative
        lsr r0, #1

        mov r1,  #90
        bl divmod

        //Add minimum
        add r1, #10

        ldr r0, =out
        bl printf

        //Increment counter
        add r4, #1

        bal while
    # }
    whileEnd:


    pop {pc}
