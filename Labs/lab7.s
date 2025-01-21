.global main

.section .data //Initialized data
    input: .word 0

.section .rodata //Readonly data
    prompt: .asciz "Enter your grade as a percentage: "
    inPat:  .asciz "%d"
    outRes: .asciz "Your letter grade: %c\n"

.section .bss //Uninitialized data

.text
main:
    push {lr}

    //do-while for data checking
    doInput:
        //Prompt for input
        ldr r0, =prompt
        bl printf
        //Get input
        ldr r0, =inPat
        ldr r1, =input
        bl scanf
        //Load input into r4
        ldr r4, =input
        ldr r4, [r4]

        //while(input < 0)
        cmp r4, #0
        blt doInput

    //---Output result---//
    ldr r0, =outRes //Output string
    //Grade C-A (70%+)
    cmp r4, #70
    bge gradeC
    //Grade D or F (69%-)
    bal gradeD

gradeC:
    //Check for B or A
    cmp r4, #80
    bge gradeB
    //Otherwise print grade C
    mov r1, #'C'
    bal printRes
gradeB:
    //Check for A
    cmp r4, #90
    bge gradeA
    //Otherwise print grade B
    mov r1, #'B'
    bal printRes
gradeA:
    mov r1, #'A'
    bal printRes

gradeD:
    //Check for F
    cmp r4, #59
    ble gradeF
    //Otherwise print grade D
    mov r1, #'D'
    bal printRes
gradeF:
    //Print grade F
    mov r1, #'F'
printRes:
    bl printf

    //return 0
    mov r0, #0
    pop {pc}
