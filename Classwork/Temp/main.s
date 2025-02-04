.global main

.section .data  
    in: .asciz "%c"
    out: .asciz "%d\n"
    n: .word 0

.text
main:
    push {lr}

    ldr r0, =in
    ldr r1, =n
    bl scanf

    ldr r0, =n
    ldr r0, [r0]

    cmp r0, #67
    moveq r1, #0
    movne r1, #255

    ldr r0, =out
    bl printf

    mov r0, #0
    pop {pc}
