.global main

.section .data //Initialized Variables
.section .rodata //Readonly Data
    outStr: .asciz "%x\n"
.section .bss //Uninitialized Variables

.text
main:
    //Keep track of where I came from
    push {lr}

    mov r0, #0b0111 //7 in binary
    mov r1, #0b1001 //9 in binary

    //Operations
    //And operation
    //and r0, r1 //And 7 and 9
                 //  0111
                 //& 1001
                 //--------
                 //= 0001
    //Or operation
    //orr r0, r1 //or 7 and 9
                 //   0111
                 //|| 1001
                 //--------
                 //=  1111
    //xor operation
    //eor r0, r1 //xor 7 and 9
                 //  0111
                 //^ 1001
                 //--------
                 //= 1110
    //Bit clear operation specified bits to zero (if not already)
    mov r2, #0b0010 //I want to turn off the 2nd bit from the right in 0b0111 (r0)
    bic r0, r2        //Clear that 2nd bit and put the result in r0
                        //


    

    //prep for printf
    mov r1, r0
    ldr r0, =outStr
    //printf(r0, r1, r2, r3)
    bl printf

    
    //Resume where I left off
    pop {pc}
