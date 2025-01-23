.global main

.section .data
    speed: .word 0
    time:  .word 0
    dist:  .word 0

.section .rodata
    prmpt1:  .asciz "Enter the speed of the vehicle in mph: "
    prmpt2:  .asciz "Enter the time the vehicle traveled in hours: "
    outRes1: .asciz "Hour\tDistance\n----------------------\n"
    outRes2: .asciz "%d   \t%d\n"
    inPat:   .asciz "%d"

.text
main:
    push {lr}

    valSpeed:
        //Prompt for input 1
        ldr r0, =prmpt1
        bl printf
        //Get input 1
        ldr r0, =inPat
        ldr r1, =speed
        bl scanf

        //Loop if input is invalid
        ldr r0, =speed
        ldr r0, [r0]
        cmp r0, #0
        blt valSpeed
        
    
    valTime:
        //Prompt for input 2
        ldr r0, =prmpt2
        bl printf
        //Get input 2
        ldr r0, =inPat
        ldr r1, =time
        bl scanf

        //Loop if input is invalid
        ldr r0, =time
        ldr r0, [r0]
        cmp r0, #0
        ble valTime

    //Output table labels
    ldr r0, =outRes1
    bl printf

    //Load values
    ldr r5, =speed
    ldr r5, [r5]
    ldr r6, =time
    ldr r6, [r6]
    ldr r7, =dist
    ldr r7, [r7]

    
    //Loop through math and outputs
    //For loop counter
    mov r4, #1 //int i = 1;
    for: # {
        //Check i for(...;i <= time;...)
        cmp r4, r6
        bgt forEnd

        //Calculate distance after i hours
        add r7, r5 //dist = dist + speed

        //Output result for hour
        ldr r0, =outRes2
        //Push counter and distance values
        //--------------
        push {r4}
        push {r7}
        //--------------
        mov r1, r4
        mov r2, r7
        bl printf

        //Restore counter and distance registers
        pop {r7}
        pop {r4}

        //Increment counter
        add r4, #1

        //Branch back to start of loop
        bal for
        
    # }
forEnd:
    
    //return 0
    mov r0, #0
    pop {pc}
