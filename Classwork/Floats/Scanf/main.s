.global main

.section .data
    x: .float 0.0

.section .rodata
    prompt: .asciz "Enter a floating point number: "
    inFlt: .asciz "%f"
    outRes: .asciz "Entered: %f\n"

.text
main:
    push {lr}

    //Prompt for input
    ldr r0, =prompt
    bl printf
    //Get input
    ldr r0, =inFlt
    ldr r1, =x
    bl scanf
    
    ldr r0, =outRes
    ldr r1, =x
    vldr s0, [r1] //Dereference with vector load
    vcvt.f64.f32 d0, s0 //Convert to 64bit into d0
    vmov r1, r2, d0 //Move to r1 and r2
    bl printf

    pop {pc}
