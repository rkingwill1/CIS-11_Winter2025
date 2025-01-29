.global main
.global passByVal

.section .data
    val1: .word 123
    val2: .word 100
    val3: .word 256

.section .rodata
    outVal1: .asciz "Val1: %d\n"
    outVal2: .asciz "Val2: %d\n"
    outVal3: .asciz "Val3: %d\n"
    outPBV: .asciz "passByVal function\n\n"
    outSum: .asciz "Sum: %d\n"
    outEndPass: .asciz "\nEnd passByVal function\n"

.text
main: # {
    push {lr}

    //Print Value 1
    ldr r0, =outVal1
    ldr r1, =val1
    ldr r1, [r1]
    bl printf
    //Print Value 2
    ldr r0, =outVal2
    ldr r1, =val2
    ldr r1, [r1]
    bl printf
    //Print Value 3
    ldr r0, =outVal3
    ldr r1, =val3
    ldr r1, [r1]
    bl printf

    //Load parameters for passByVal(val1, val2, val3)
    ldr r0, =val1
    ldr r0, [r0]
    ldr r1, =val2
    ldr r1, [r1]
    ldr r2, =val3
    ldr r2, [r2]

    bl passByVal

    mov r0, #0
    pop {pc}    

# }

passByVal: # {
    push {r4, r5, r6, lr}

    //Save r0, r1, r2 by pushing
    push {r0-r3}

    //Indicate start of function
    ldr r0, =outPBV
    bl printf

    //Pop variables
    pop {r0-r3}
    //Do math for sum
    add r4, r0, r1
    add r4, r2

    //Push values
    push {r0-r3}
    //Output sum
    ldr r0, =outSum
    mov r1, r4
    bl printf
    //Pop
    pop {r0-r3}

    //Edit passed values
    add r0, #1
    add r1, #3
    sub r2, #4

    //Move values to safe registers
    mov r4, r0
    mov r5, r1
    mov r6, r2

    //Print the new values
    ldr r0, =outVal1 //val1
    mov r1, r4
    bl printf
    ldr r0, =outVal2 //val1
    mov r1, r5
    bl printf
    ldr r0, =outVal3 //val1
    mov r1, r6
    bl printf

    ldr r0, =outEndPass
    bl printf

    //No retrun 0 because not in main
    pop {r4-r6, pc}

# }
