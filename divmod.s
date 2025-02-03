.global divmod

.section .data

.section .rodata

.text
divmod:
    push {lr}

    //Move operands
    mov r4, r1
    mov r5, r0

    //Initialize variables
    mov r0, #0  //rDiv = 1
    mov r1, r5  //rMod = numerator
    mov r2, #1  //increment = 1

    do: # {
        //Value shifting
        lsl r4, #1  //denom << 1
        lsl r2, #1  //increment << 1

        //Condition check
        cmp r1, r4  
        bgt do      //rMod > denom

    # }

    //Undo one shift
    lsr r4, #1
    lsr r2, #1

    while1: # {
        //Condition check
        cmp r1, r4
        blt while1End  //exit when rMod < denom

        //
        add r0, r2  //r0 = divMod + increment
        sub r1, r4  //r1 = rMod - denom


        while2: # {
            //Condition check
            cmp r2, #1
            ble while2End
            cmp r4, r1
            ble while2End
            //Shift values
            lsr r2, #1  //increment >> 1
            lsr r4, #1  //denom >> 1

            bal while2
        # }
        while2End:

        bal while1
    # }
    while1End:

    

    pop {pc}
