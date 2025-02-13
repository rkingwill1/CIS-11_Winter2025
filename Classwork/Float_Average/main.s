.global main

.section .data
    input: .float 0.0
    five: .float 5.0

.section .rodata
    prompt: .asciz "Enter 5 numbers to average: \n"
    prmptElem: .asciz "Enter num %d: "
    inFlt: .asciz "%f"
    outRes: .asciz "Your average is %f\n"

    debug: .asciz "Debug: %f\n"

.text
main:
    push {lr}

    //Prompt for instruction
    ldr r0, =prompt
    bl printf

    //Load sum reg
    vldr s4, =#0 //int sum = 0

    mov r4, #0
    mFor: # {
        cmp r4, #5
        bge mfEnd

        //Prompt for input i
        ldr r0, =prmptElem
        add r1, r4, #1
        bl printf
        //Get input
        ldr r0, =inFlt
        ldr r1, =input
        bl scanf

        //Add into sum
        ldr r0, =input
        vldr s0, [r0]
        vadd.f32 s4, s0 //Add s0 to the sum (s4)

        //Increment counter
        add r4, #1

        bal mFor    
    # }
    mfEnd:

    ldr r0, =debug
    //Convert sum to 64bit
    vcvt.f64.f32 d4, s4
    vmov r1, r2, d4
    bl printf

    ldr r0, =five
    vldr s2, [r0]

    //divide
    vdiv.f32 s0, s4, s2

    ldr r0, =outRes
    vcvt.f64.f32 d4, s0
    vmov r1, r2, d4
    bl printf





    pop {pc}
