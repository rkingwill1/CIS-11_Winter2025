.global main

.section .rodata //Readonly
    outStr: .asciz "%08x%08x\n" //Two 32 bit values

.text
main:
    push {lr}

    //Add these numbers ()
    //n1: #0x01ffffffff
    //n2: #0xffffffffff

    //Upper n1, 0x01, lower n1 0xffffffff
    //Upper n2, 0xff, lower n2 0xffffffff
    ldr r0, =#0xffffffff //Lower half of n1          NOTE: ldr because mov has a relatively small allowed size
    ldr r1, =#0x01       //Upper half of n1 

    //load n2 into registers
    ldr r2, =#0xffffffff //lower half of n2
    ldr r3, =#0xff       //Upper half of n2

    //Adds the two lower parts (Sets the carry flag)
    adds r4, r0, r2 //lower sum into r4
    //Adds the two upper parts WITH the carry (ADC = ADd with Carry)
    adcs r5, r1, r3 //Upper sum into r5

    //Print value
    ldr r0, =outStr
    //
    //printf("%08x%08x", r5, r4)
    mov r1, r5
    mov r2, r4
    bl printf

    //return 0
    mov r0, #0

    pop {pc}
