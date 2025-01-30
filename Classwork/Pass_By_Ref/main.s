.global main
.global passByRef

.section .data
    val1: .word 123
    val2: .word 456
    val3: .word 256

.section .rodata
    outBefore: .asciz "Before passByRef function\n"
    outAfter:  .asciz "After passByRef function\n"
    outv1:     .asciz "val1: %d\n"
    outv2:     .asciz "val2: %d\n"
    outv3:     .asciz "val3: %d\n"
    outIn:     .asciz "In passByRef function\n"
    outSum:    .asciz "Sum is: %d\n"


.text
main:
    push {lr}

    //Output starting values
    ldr r0, =outBefore
    bl printf
    //Load values
    ldr r4, =val1
    ldr r5, =val2
    ldr r6, =val3
    
    ldr r0, =outv1 //v1
    ldr r1, [r4]
    bl printf
    ldr r0, =outv2 //v2
    ldr r1, [r5]
    bl printf
    ldr r0, =outv3 //v3
    ldr r1, [r6]
    bl printf

    //Load parameter addresses and call passByValue
    mov r0, r4
    mov r1, r5
    mov r2, r6
    bl passByRef

    //Print post-function values
    ldr r0, =outAfter 
    bl printf
    ldr r0, =outv1 //v1
    ldr r1, [r4]
    bl printf
    ldr r0, =outv2 //v2
    ldr r1, [r5]
    bl printf
    ldr r0, =outv3 //v3
    ldr r1, [r6]
    bl printf



    pop {pc}


//r0 = *v1
//r1 = *v2
//r2 = *v3
passByRef:
    push {r4-r7, lr}

    //Load values to safer registers
    mov r4, r0
    mov r5, r1
    mov r6, r2

    //Indicate start of fuction
    ldr r0, =outIn
    bl printf
    //Load VALUES into registers
    ldr r0, [r4]
    ldr r1, [r5]
    ldr r2, [r6]

    //Sum the values
    add r3, r0, r1
    add r3, r2

    
    //Modify values
    add r0, #5
    add r1, #10
    mov r7, #2 //Can't multiply literals
    mul r2, r7

    //Store values back
    str r0, [r4] //Store r0 into r4
    str r1, [r5] //Store r1 into r5
    str r2, [r6] //Store r2 into r6

    //Print sum
    push {r0-r2} //Temporarilly push to stack
    ldr r0, =outSum
    mov r1, r3 //Move sum
    bl printf
    pop {r0-r2} //Pop values back

    //Print values
    //v1
    push {r1, r2}
    mov r1, r0      
    ldr r0, =outv1
    bl printf
    pop {r1, r2}
    //v2
    push {r2}
    ldr r0, =outv2  
    bl printf //v2 already popped to r1
    pop {r1}
    //v3
    ldr r0, =outv3  
    bl printf //v3 already popped to 41



    pop {r4-r7, pc}
