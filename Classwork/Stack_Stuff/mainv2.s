.global main

.section .data
    out: .asciz "%d, %d\n"

.text
main:
    push {lr}

    //Push 25 to the stack
    mov r1, #25

    mov r0, #16
    stmdb sp!, {r0-r1} //Decrements sp before it writes back

    @ add sp, #8

    //Remove multiple and increment afterwards to remove them from the stack
    //! writes back to the stack pointer to do that increment by 4
    ldmia sp!, {r1-r2}

    ldr r0, =out
    bl printf


    mov r0, #0
    pop {pc}
