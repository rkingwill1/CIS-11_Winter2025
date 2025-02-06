.global main

.section .rodata
    inPat: .asciz "%d"
    out:   .asciz "Read in %d\n"

.text
main:
    str lr, [sp, #-4]! //same as push {lr}

    ldr r0, =inPat
    sub sp, #4 //Allocate 4bytes of space in stack
    mov r1, sp //Copy sp address into r1
    bl scanf

    ldr r0, =out
    ldr r1, [sp], #4
    bl printf

    //add sp, #4


    ldr pc, [sp], #4
