.global main

.section .data
    num1: .float 0
    num2: .float 0

.section .rodata
    prompt: .asciz "Enter 2 numbers %%f %%f \n"
    inPat:  .asciz "%f %f"
    outLess: .asciz "num1 is less than num2\n"
    outMore: .asciz "num1 is greater than num2\n"
    outEq: .asciz "num1 is equal to num2\n"

.text
main:
    push {lr}

    //Prompt for input
    ldr r0, =prompt
    bl printf
    //Get inputs
    ldr r0, =inPat
    ldr r1, =num1
    ldr r2, =num2
    bl scanf

    //Load num 1
    ldr r0, =num1
    vldr s0, [r0]

    ldr r1, =num2
    vldr s2, [r1]

    vcmp.f32 s0, s2

    //In order to use the floating point status register, I need to 
    //copy it to the regular cpsr (current program status register) register
    //To copy the floating status (FPSCR) to my general purpose cpsr (APSR_nzcv)
    vmrs APSR_nzcv, FPSCR
    
    blt less
    bgt more
    b equal

    less:
    ldr r0, =outLess
    bl printf
    b end

    equal:
    ldr r0, =outEq
    bl printf
    b end

    more:
    ldr r0, =outMore
    bl printf

    end:

    mov r0, #0
    pop {pc}
