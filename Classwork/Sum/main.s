.global main

.section .data
    r1: .word 25
.section .rodata
    outStr: .asciz "the sum is: %d\n"
.section .bss

.text
main:
    //Store where we came from
    push {lr}

    //move 20 into r0
    mov r0, #20
    //load 25 into the data register
    ldr r1, =r1 //Gets address of r1 label
    //to get the value i need to dereference it
    //I have address in r1, I want the number 25 to go into r1, so [] to dereference r1
    ldr r1, [r1]
    //Lastly move 5 into r3
    mov r3, #5

    //Add them all together, store sum in r0
    add r0, r0, r1 //r0 = r0 + r1
    add r0, r0, r3 //r0 = r0 + r3

    //printf
    //Move my answer from r0 so I don't overwrite it
    mov r1, r0
    //Load the strings
    ldr r0, =outStr
    //Call printf
    bl printf

    //Exit and return 0
    mov r0, #0
    //Call exit
    pop {pc}

