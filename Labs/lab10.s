.global main
.global getLength
.global getWidth
.global getArea
.global displayData

.section .data //Initialized data
    l: .word 0
    w: .word 0
    area: .word 0


.section .rodata //Readonly data
    prmptL: .asciz "Enter the Length of the rectangle: "
    prmptW: .asciz "Enter the Width of the rectangle: "
    inPat: .asciz "%d"
    outRes: .asciz "Area: %d\n"

.section .bss //Uninitialized data

.text
main:
    push {lr}

    //Get Length
    bl getLength //Returns length in r0
    mov r4, r0 //Save r0(Length) into r4

    //Get Width
    bl getWidth //Returns width into r1
    mov r0, r4 //Move length to r0 again

    //Caclulate Area 
    bl getArea //Takes r0 and r1, returns restult into r1

    //Display results
    bl displayData

    //return 0
    mov r0, #0
    pop {pc}

getLength:
    push {lr}

    //Prompt for input
    ldr r0, =prmptL
    bl printf
    //Get input
    ldr r0, =inPat
    ldr r1, =l
    bl scanf

    //Load length to be returned
    ldr r0, =l
    ldr r0, [r0]

    pop {pc}

getWidth:
    push {lr}

    //Prompt for input
    ldr r0, =prmptW
    bl printf
    //Get input
    ldr r0, =inPat
    ldr r1, =w
    bl scanf

    //Load length
    ldr r1, =w
    ldr r1, [r1]


    pop {pc}

getArea:
    push {lr}

    //Calculate area
    mul r1, r0, r1 //r1 = l * w


    pop {pc}


displayData:
    push {lr}

    ldr r0, =outRes
    //r1 already has the area
    bl printf


    pop {pc}
