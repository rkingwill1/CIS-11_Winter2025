.global initRand
.global getRand

.extern time
.extern srand
.extern rand
.extern divmod

//Sets random seed
//void initRand()
initRand: 
    stmdb sp!, {lr}

    mov r0, #0
    bl time
    bl srand

    


    ldmia sp!, {pc}

//getRand(int modby, int addby)
//r0 = modby
//r1 = addby
getRand:
    stmdb sp!, {r1-r5, lr}

    //Move modby and addby to safe registers
    mov r4, r0
    mov r5, r1

    bl rand //Gets random value into r0
    lsr r0, #1 //Make sure there are no negative values

    //r0/r1
    mov r1, r4 //modby into r1
    bl divmod

    //Add minimum value
    add r0, r1, r5 //r0 = r1(rand % modby) + r5(addby)

    //Return rand() % modby + addby


    ldmia sp!, {r1-r5, pc}
