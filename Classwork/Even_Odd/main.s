.global main

.section .data //Initialized Variables
    num: .word 0

.section .rodata //Readonly Data
    inPat:   .asciz "%d"
    prmpt:   .asciz "Enter a number: "
    outEven: .asciz "Your number %d is even.\n"
    outOdd:  .asciz "your number %d is odd.\n"

.section .bss //Uninitialized Variables

.text
main:
    push {lr}

    //Prompt for input
    ldr r0, =prmpt
    bl printf
    //Get input
    ldr r0, =inPat
    ldr r1, =num
    bl scanf

    //Load register
    ldr r1, =num //r1 so that we don't have to load the num again to print it later
    ldr r1, [r1]
    
    //Check number
    tst r1, #1 //if((num & 1) == 0)
    beq even   //   goto even;
    bal odd    //else {goto odd;}
    //Alternative way using and
    //and r2, r1, #1
    //cmp r2, #0
    //beq even
    //bal odd


even: //Number is even
    ldr r0, =outEven
    //ldr r1, =num          //r1 is already num's value
    //ldr r1, [r1]
    bl printf
    
    bal end

odd:  //Number is odd
    ldr r0, =outOdd
    //ldr r1, =num          //r1 is already num's value
    //ldr r1, [r1]
    bl printf

end:
    //return 0
    mov r0, #0
    pop {pc}
