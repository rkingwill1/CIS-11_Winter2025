.global main
.global sort

.section .rodata
    prompt: .asciz "Input value #%d: "
    inPat:  .asciz "%d"
    outRes1: .asciz "-----Sorted array from biggest to smallest-----\n"
    outRes2: .asciz "%d\n"
    debug:   .asciz "Debug: %d\n"
    debug2:   .asciz "Debug2: %d\n"

.section .bss
    .align 4
    arr: .space 40

.text
main:
    push {lr}

    //Load array
    ldr r5, =arr

    //Get inputs
    mov r4, #0 //int i = 0;
    inputFor: # {
        cmp r4, #10
        bge inputForEnd

        //Prompt for input
        ldr r0, =prompt
        add r1, r4, #1
        bl printf
        //Get input 
        ldr r0, =inPat
        mov r1, r5
        bl scanf

        //Increment counter & arr pointer
        add r4, #1
        add r5, #4

        bal inputFor
    # }
    inputForEnd:

    ldr r0, =arr
    mov r1, #10
    bl sort


    pop {pc}
    
//r0 = arr*
//r1 = size
sort:
    push {r4-r6, lr}

    //Move array starting address to safe address
    mov r5, r0
    

    
    

    mov r4, #0 //int i = 0;
    sortFor: # {
        cmp r4, #9
        bge sortForEnd

        
        add r3, r4, #1 //int j(r3) = i(r4) + 1;
        //Adjust array index
        mov r5, r0 //Start of array
        lsl r6, r3, #2 //Index j * 4 (mult by 4 because 4bytes per index)
        add r5, r6
        sortFor2: # {
            cmp r3, #10
            bge sortFor2End

            

            //Load current value
            ldr r1, [r5]

            //Load prev array value
            sub r5, #4
            ldr r2, [r5]
            add r5, #4
            
            //sort
            cmp r2, r1
            strgt r2, [r5]
            subgt r5, #4
            strgt r1, [r5]
            addgt r5, #4

            //Increment
            add r3, #1
            add r5, #4


            bal sortFor2

        # }
        sortFor2End:

        //Increment counter and pointer
        add r4, #1

        bal sortFor                                         @ 3, 7, 23, 4, 8, 45, 34, 9, 87, 2
    # }
    sortForEnd:

    ldr r0, =outRes1
    bl printf

    ldr r5, =arr

    //Output array
    mov r4, #0 // int i = 0;
    outFor: # {
        cmp r4, #10
        bge outForEnd

        ldr r0, =outRes2
        ldr r1, [r5]
        bl printf

        //Increment
        add r4, #1
        add r5, #4

        bal outFor
    # }
    outForEnd:

    

    pop {r4-r6, pc}
