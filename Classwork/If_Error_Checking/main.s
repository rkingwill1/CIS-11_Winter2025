.global main

.section .data //Ininitialized Variables
    w: .word 0
    l: .word 0

.section .rodata //Readonly data
    inPat: .asciz "%d"
    prompt1: .asciz "Enter a width: "
    prompt2: .asciz "Enter a length: "
    outStr:  .asciz "Calculated area: %d\n"
    errW:    .asciz "Width cannot be negative.\n"
    errL:    .asciz "Length cannot be negative.\n"
    outSqr:  .asciz "Your shape is a square!\n"
    outRec:  .asciz "Your shpae is a rectangle...\n"

.section .bss //Uninitialized Variables
    area: .space 4 //4 bytes of space

.text
main:
    push {lr}

    //Prompt user for width
    ldr r0, =prompt1
    bl printf
    //Get width
    ldr r0, =inPat
    ldr r1, =w
    bl scanf

    //Prompt user for length
    ldr r0, =prompt2
    bl printf
    //Get length
    ldr r0, =inPat
    ldr r1, =l
    bl scanf

    //Load regeisters to prep for operations
    ldr r1, =l
    ldr r1, [r1]
    ldr r2, =w
    ldr r2, [r2]

    //Validate data
    cmp r1, #0    //Make sure length is positive
    blt invalidL
    cmp r2, #0    //Make sure width is positive
    blt invalidW

    //Operations
    mul r3, r1, r2 //r3 = r1 * r2

    //Store result
    ldr r4, =area //Load r1 with the area variable's address
    str r3, [r4]  //Store the result value into that address location (r1* = area = r3)

    //Check if square
    cmp r1, r2
    beq square //if(r1 == r2) goto square;
    bal rect   //else {goto rect;}


square: //Shape is a square
    //Notify user
    ldr r0, =outSqr
    bl printf
    bal outputArea

rect: //Shape is a rectangle
    //Notify user
    ldr r0, =outRec
    bl printf

outputArea:
    //Output results
    ldr r0, =outStr
    ldr r1, =area //Address of area
    ldr r1, [r1]  //Dereference to get area value
    bl printf

    bal end

invalidW: //Print error message if width is negative
    ldr r0, =errW
    bl printf

    bal end
    
invalidL: //Print error message if length is negative
    ldr r0, =errL
    bl printf

    bal end




end: //return 0
    mov r0, #0
    pop {pc}
