.global main

.section .data
    x: .float 0.0
    y: .float 2.35
    z: .float -9.87654
    w: .float 4.56123

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

    //Load number from scanf
    ldr r1, =x
    vldr s0, [r1] //Dereference with vector load
    //Load y
    ldr r1, =y
    vldr s1, [r1]
    //Load z
    ldr r1, =z
    vldr s2, [r1]
    //Load w
    ldr r1, =w
    vldr s3, [r1]

    //-----MATH-----//
    //t = -(x * y)
    vnmul.f32 s4, s0, s1
    //t = t + (z * w)
    //s4 = s4 + (s2 + s3)
    vmla.f32 s4, s2, s3
    
    //Print
    ldr r0, =outRes
    vcvt.f64.f32 d0, s4 //Convert to 64bit into d0          //NOTE: this wipes whatever is in s1
    vmov r1, r2, d0 //Move to r1 and r2
    bl printf

    pop {pc}
