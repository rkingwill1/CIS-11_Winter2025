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

    bl getLength

    
    ldr r0, =outRes
    mov r1, r4


    bl printf

    bl getWidth

    bl getArea

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

    //Load length
    ldr r4, =l
    ldr r4, [r4]

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
    ldr r5, =l
    ldr r5, [r5]


    pop {pc}

getArea:
    push {lr}

    mul r4, r5


    pop {pc}


displayData:
    push {lr}

    ldr r0, =outRes
    mov r1, r4


    pop {pc}
