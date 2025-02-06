.global main
.global fToC
.global cToF

//External function
.extern divmod

.section .data    
    input: .word 0

.section .rodata
    prmpt: .asciz "What do you want to convert a temperature to (C or F): "
    prmptC: .asciz "Enter the temperature in Celsius: "
    prmptF: .asciz "Enter the temperature in Fahrenheit: "
    outF: .asciz "The temperature in Fahrenheit is %d\n"
    outC: .asciz "The temperature in Celsius is %d\n"
    inChar: .asciz "%c"
    inInt:  .asciz "%d"
    wip: .asciz "Work in Progress\n"

.text
main:
    push {lr}

    inputDo: # {
        //Prompt user
        ldr r0, =prmpt
        bl printf
        //Get Input (F or C)
        ldr r0, =inChar
        ldr r1, =input
        bl scanf

        //Conditions check
        ldr r4, =input
        ldr r4, [r4]
        cmp r4, #67 //is C
        beq skip
        cmp r4, #70 //is F
        
        skip:
        bne inputDo
    # }

    //Prompt for input
    cmp r4, #70
    ldreq r0, =prmptC
    ldrne r0, =prmptF
    bl printf
    //Get input
    ldr r0, =inInt
    ldr r1, =input
    bl scanf

    ldr r0, =input
    ldr r0, [r0]
    //Call functions
    cmp r4, #70
    blne fToC
    cmp r4, #70
    bleq cToF


    mov r0, #0
    pop {pc}


fToC:
    push {lr}

    //MATH
    sub r0, #32
    mov r3, #5
    mul r0, r3
    mov r1, #9
    //Divide
    bl divmod    

    //Output
    mov r1, r0
    ldr r0, =outC
    bl printf

    pop {pc}

cToF:
    push {lr}

    //MATH
    mov r3, #9
    mul r0, r3
    mov r1, #5
    //Divide
    bl divmod   
    //Add
    add r0, #32
    
    //Output
    mov r1, r0
    ldr r0, =outF
    bl printf


    pop {pc}
