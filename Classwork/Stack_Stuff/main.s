.global main

.section .data
    o: .asciz "%d\n"

.text
main:
    push {lr}

    //Manually store value into stack
    sub sp, #4   //Allocate 4bytes of space
    mov r0, #25  //Store 25 into r0
    str r0, [sp] //Store r0 value (25) into stack

    sub sp, #4   //Allocate 4bytes of space
    mov r0, #16  //Store 16 into r0
    str r0, [sp] //Store r0 (16) into stack

    

    //Pop
    ldr r1, [sp]
    add sp, #4
    

    //Output
    ldr r0, =o
    ldr r1, [sp]
    bl printf



    mov r0, #0
    pop {pc}
