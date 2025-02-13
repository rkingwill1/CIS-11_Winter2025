.global main

.section .data
    a: .float 1.0000001
    b: .float 1.0000002
    delta: .float 0.00001

.section .rodata
    outEq: .asciz "Equal\n"
    outNe: .asciz "Not equal\n"
    outDelEq: .asciz "Equal within delta\n"
    outDelNe: .asciz "Not equal within delta\n"

.text
main:
    push {lr}

    //Load numbers
    ldr r0, =a
    vldr s0, [r0]
    ldr r0, =b
    vldr s2, [r0]
    ldr r0, =delta
    vldr s6, [r0]

    vcmp.f32 s0, s2
    //Copy floating point compare to general compare
    vmrs APSR_nzcv, FPSCR

    //Load the string based on the cpsr (current program status register)
    ldreq r0, =outEq
    ldrne r0, =outNe
    bl printf

    //Subtract sum a and b
    vsub.f32 s4, s0, s2
    //New instruction instead of branching to fabs
    vabs.f32 s4, s4
    vcmp.f32 s4, s6
    vmrs APSR_nzcv, FPSCR

    ldrlt r0, =outDelEq
    ldrge r0, =outDelNe
    bl printf




    mov r0, #0
    pop {pc}
