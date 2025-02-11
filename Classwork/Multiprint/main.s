.global main

.section .data
    x: .float 0.0
    y: .float 2.35
    z: .float -9.87654
    w: .float 4.56123

.section .rodata
    prompt: .asciz "Enter a floating point number: "
    inFlt: .asciz "%f"
    outRes: .asciz "Value entered was %f; (y = %f, z = %f, w = %f). The sum is %f\n"

.text
main:
    push {fp, lr} //Push frame pointer 
    mov fp, sp //Mark the stack pointer as the beginning of the frame pointer
                  //Is like a marker on the computer's memory stack that points at the
                  //beginning of a specific function's data
                  //Acting as a reference point to easily access LOCAL 
                  //variables and arguments within that function 
                  //Like a stack of boxes where each box is a function call
                  //allowing you to easily identify data for the current function

    //Prompt input
    ldr r0, =prompt
    bl printf
    //Get input
    ldr r0, =inFlt
    ldr r1, =x
    bl scanf

    //Load the string for printing
    ldr r0, =outRes

    //Get user's number
    ldr r2, =x
    vldr s0, [r2]
    //Convert to 64 bit 
    vcvt.f64.f32 d5, s0
    //Make copy of d5 into d6 for the sum(need .f64 because 32 is default)
    vmov.f64 d6, d5
    //Move to printing registers
    vmov r2, r3, d5

    //Allocate space on stack (4 8byte numbers)
    sub sp, #32

    //Load y
    ldr r4, =y
    vldr s0, [r4]
    vcvt.f64.f32 d5, s0
    //Add x and y
    vadd.f64 d6, d5
    //Store d5 (y) into the stack without allocating
    vstr d5, [sp]

    //Load z
    ldr r4, =z
    vldr s0, [r4]
    vcvt.f64.f32 d5, s0
    //Add into sum
    vadd.f64 d6, d5
    //Store d5 (z) into the stack without allocating
    vstr d5, [sp, #8] //Add 8 first to get new spot in stack

    //Load w
    ldr r4, =w
    vldr s0, [r4]
    vcvt.f64.f32 d5, s0
    //Add to sum
    vadd.f64 d6, d5
    //Store into stack without allocating
    vstr d5, [sp, #16] //Add 16 first for new spot

    //Store the sum
    vstr d6, [sp, #24]

    //Call printf
    bl printf

    //Clean the stack
    add sp, #32
    
    mov r0, #0 //Return 0
    mov sp, fp //Return the frame pointer back to the stack pointer
    pop {fp, pc}
