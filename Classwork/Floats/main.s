.global main

.section .data
    val1: .float 3.14159
    val2: .float 0.10

.section .rodata
    outRes: .asciz "The result is %F\n"

.text
main:
    stmdb sp!, {lr}

    //Load values
    ldr r0, =val1
    vldr s0, [r0] //Vector load for floats, into a float register (s0)

    ldr r0, =val2
    vldr s2, [r0]

    //Math
    vmul.f32 s0, s2

    //Move floating point out of the vfp registers so it can be printed
    //However, the float must be promoted to double precision because printf wants doubles
    //Convert to 64bit to 32bit (Vectore ConVerT)
    vcvt.f64.f32 d0, s0
    //Move to r1 AND r2 (64bit needs 2 registers)
    vmov r1, r2, d0  


print:
    ldr r0, =outRes
    bl printf




    ldmia sp!, {pc}
