.global main
.global fallingDistance

.section .data
    t: .word 1
    g: .word 9

.section .rodata
    inPat: .asciz "%d"
    outRes1: .asciz "Time(s)\tDistance(m)\n"
    outRes2: .asciz "%d     \t%d\n"

.text
main:
    push {lr}


    //Load parameters
    ldr r4, =t
    ldr r4, [r4]

    mainFor: # {
        //Check variables
        cmp r4, #10
        bgt endFor

        //Print result labels
        ldr r0, =outRes1
        bl printf

        //Load parameter with t
        mov r1, r4 //t into r1
        //Call function
        bl fallingDistance //Returns result in r2

        //Print result
        ldr r0, =outRes2
            //t is already in r1
            //result is already in r2
        bl printf

        //Increment t
        add r4, #1

        //Branch back
        bal mainFor
    
    endFor:

    pop {pc}

//r1 = t
fallingDistance:
    push {lr}

    //Load registers
    ldr r0, =g
    ldr r0, [r0]

    //Calculate distance
    mul r0, r1     //r1 = t * g
    mul r2, r0, r1 //r1 = (g * t) * t
    lsr r2, #1     //r1 = 1/2(g * t^2)

    //Returns result in r2

    pop {pc}
