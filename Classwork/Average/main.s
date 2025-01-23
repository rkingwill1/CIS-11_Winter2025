.global main

.section .data //Initialized data
    sum: .word 0

.section .rodata //Readonly data
    prompt: .asciz "Enter a positive number: "
    inPat: .asciz "%d"
    outRes: .asciz "Average: %d\n"

.section .bss //Uninitialized data
    input: .space 4

.text
main:
    push {lr}

    //Get user input for 5 positive integers
    mov r4, #0 //int i = 0;
    ldr r6, =sum //r6* = sum;
    ldr r5, [r6] //r5 = &r6;
    for: # {
        //Check i (loop if i < 5)
        cmp r4, #5
        bge forEnd
        
        do: # {
            //Prompt for input
            ldr r0, =prompt
            bl printf
            //Get input
            ldr r0, =inPat
            ldr r1, =input
            bl scanf

            //Loop input <= 0 (while(input > 0))
            ldr r1, =input
            ldr r1, [r1]
            cmp r1, #0
            blt do
        # }

        //sum = sum + input
        add r5, r1
        //Store sum
        str r5, [r6] //Storing r5's value into the address r6 holds (address of sum)

        //i++
        add r4, #1

        //Loop back
        bal for



    # }
    forEnd:

    //-----Calculate average-----//
    //r2 = 001100110011 = 0.2 shifted to be a whole number
    mov r2, #0x334
    //Load sum into r2
    ldr r1, =sum
    ldr r1, [r1]
    //Multiply
    mul r1, r2

    //Logical shift right
    lsr r1, #12 //avg(r2) >> 12

    //Output result
    ldr r0, =outRes
    //mov r1, r2      //We did this already when we multiplied
    bl printf



    mov r0, #0
    pop {pc}
