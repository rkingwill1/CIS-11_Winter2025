.global main

.section .data
    value: .word 0
    shiftBy: .word 0

.section .rodata
    prmpt: .asciz "Enter a 32 bit number and the number of bits to shift by: "
    inPat: .asciz "%d %d"
    outlsl: .asciz "%d (0x%08X) LSL #%d = %d (0x%08X)\n"
    outlsr: .asciz "%d (0x%08X) LSR #%d = %d (0x%08X)\n"
    outasr: .asciz "%d (0x%08X) ASR #%d = %d (0x%08X)\n"
    outror: .asciz "%d (0x%08X) ROR #%d = %d (0x%08X)\n"

.text
main:
    push {lr}

    //Prompt for input
    ldr r0, =prmpt
    bl printf
    //Get inputs
    ldr r0, =inPat
    ldr r1, =value
    ldr r2, =shiftBy
    bl scanf

    //Load value and shiftBy for logical shift
    ldr r4, =value
    ldr r4, [r4]
    ldr r5, =shiftBy
    ldr r5, [r5]


    //-----Logical shift left-----//
    lsl r0, r4, r5     //pseudo operation
    mov r0, r4, lsl r5 //real instruction (They do the same exact thing)

    //Output all the shifts - "%d (0x%08X) LSL #%d = %d (0x%08X)\n"
    mov r1, r4 //Value to be shifted
    mov r2, r4 //Same thing for the hex version
    mov r3, r5 //Amount of bits to be shifted
    //We have exceeded out 4 parameter limit
    //So now we have to use the stack to put more parameters
    push {r0} //Puts shifted value onto the stack
    push {r0} //Same thing for the hex version
    ldr r0, =outlsl
    bl printf
    //Pop the pushed values
    add sp, #8 //Clears 8 bytes (the two 4byte r0 values we pushed)

    //-----Logical shift right-----//
    lsr r0, r4, r5 //Pseudo operation shift r4 by r5 and store in r0
    mov r0, r4, lsr r5 //Translation (they do the same exact thing)
    //Output results
    mov r1, r4
    mov r2, r4
    mov r3, r5
    push {r0}
    push {r0}
    ldr r0, =outlsr
    bl printf
    //Clean stack
    add sp, #8 //Clears 8 bytes (the two 4byte r0 values we pushed)

    //-----Arithmetic shift right-----//
    asr r0, r4, r5 //Pseudo operation shift r4 by r5 and store in r0
    mov r0, r4, asr r5 //Translation (they do the same exact thing)
    //Output results
    mov r1, r4
    mov r2, r4
    mov r3, r5
    push {r0}
    push {r0}
    ldr r0, =outasr
    bl printf
    //Clean stack
    add sp, #8 //Clears 8 bytes (the two 4byte r0 values we pushed)

    //-----Rotate right-----//
    ror r0, r4, r5 //Pseudo operation shift r4 by r5 and store in r0
    mov r0, r4, ror r5 //Translation (they do the same exact thing)
    //Output results
    mov r1, r4
    mov r2, r4
    mov r3, r5
    push {r0}
    push {r0}
    ldr r0, =outror
    bl printf
    //Clean stack
    add sp, #8 //Clears 8 bytes (the two 4byte r0 values we pushed)

    //return 0
    mov r0, #0
    pop {pc}
