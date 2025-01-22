.global main

.section .data //Initialized data
    min: .word 2147483647
    max: .word -2147483648
    input: .word 0

.section .rodata //Readonly data
    promptIntro: .asciz "-----Enter however many numbers you want (-99 to stop)-----\n"
    prompt:  .asciz "Enter a number: "
    inPat:   .asciz "%d"
    outMin:  .asciz "\nMin: %d\n"
    outMax:  .asciz "Max: %d\n"    

.section .bss //Uninitialized data

.text
main:
    push {lr}

    //Output introduction message
    ldr r0, =promptIntro
    bl printf

    //Load min and max values
    ldr r4, =min  //r4 = min
    ldr r4, [r4]
    ldr r5, =max  //r5 = max
    ldr r5, [r5]

    do: # {
        //Prompt user for input
        ldr r0, =prompt
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =input
        bl scanf

        //Exit loop if input = -99 (while(input != 99))
        ldr r0, =input
        ldr r0, [r0]
        cmp r0, #-99
        beq doEnd

        //Otherwise continue with min/max checking
        //Move input into r4 if(input < min)
        cmp r0, r4
        movlt r4, r0
        //Move input into r5 if(input > max)
        cmp r0, r5
        movgt r5, r0        


        //Branch back to start of do loop
        bal do

    # }
doEnd:
    //-----Output Results-----//
    //Output min
    ldr r0, =outMin
    mov r1, r4
    bl printf
    //Output max
    ldr r0, =outMax
    mov r1, r5
    bl printf


    //return 0
    mov r0, #0
    pop {pc}
