.global main
.global sort

.section .data
    @ .align 4
    @ arr: .word 3, 7, 23, 4, 8, 45, 34, 9, 87, 2

.section .rodata
    prompt: .asciz "Input value #%d: "
    inPat:  .asciz "%d"
    outRes1: .asciz "Min: %d\n"
    outRes2: .asciz "Max: %d\n"

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

    //Output min
    ldr r0, =arr
    bl outMin
    //Output max
    ldr r0, =arr
    mov r1, #10
    bl outMax

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

        //Load arr[i]
        mov r5, r0 //Reset r5 address
        ldr r1, [r5, r4, lsl #2] //Value
        add r7, r5, r4, lsl #2   //Address

        
        add r3, r4, #1 //int j(r3) = i(r4) + 1;
        //Adjust array index
        mov r5, r0 //Start of array
        lsl r6, r3, #2 //Index j * 4 (mult by 4 because 4bytes per index) 
        add r5, r6     //Go to index j in r5
        sortFor2: # {
            cmp r3, #10
            bge sortFor2End            

            //Load arr[j]
            ldr r2, [r5]
            
            //Check if swap
            cmp r1, r2 //Compare r1(a[i]) with r2(a[j])
            ble noSwap
            //Swap
            str r2, [r7]
            str r1, [r5] 
            ldr r1, [r7]
            ldr r2, [r5]

            noSwap:
            //Increment
            add r3, #1
            add r5, #4


            bal sortFor2
        # }
        sortFor2End:

        //Increment counter and pointer
        add r4, #1

        bal sortFor
    # }
    sortForEnd:    

    pop {r4-r6, pc}

outMin:
    stmdb sp!, {lr}

    ldr r1, [r0]
    ldr r0, =outRes1
    bl printf


    ldmia sp!, {pc}

outMax:
    stmdb sp!, {lr}
    
    sub r1, #1

    ldr r1, [r0, r1, lsl #2]
    ldr r0, =outRes2
    bl printf


    ldmia sp!, {pc}
