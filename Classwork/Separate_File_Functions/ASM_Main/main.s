.global main
.extern intSqrt

.section .rodata
    outRes: .asciz "The sqrt is %d\n"

.text
main:
    push {lr}

    mov r0, #4
    bl intSqrt

    //Move answer into r1 to print
    mov r1, r0
    ldr r0, =outRes
    bl printf
    
    pop {pc}
