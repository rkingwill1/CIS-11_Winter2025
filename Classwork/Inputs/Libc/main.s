.global main

.section .data //Initialized Variables
    in: .word 0   //Input value
    rslt: .word 0 //Stored result of operation

.section .rodata //Readonly Data
    addBy: .word 32
    inPat: .asciz "%d"  //Input pattern (datatype)
    outPat: .asciz "%s" //Output pattern (datatype)
    outPrmpt: .asciz "Enter a number: "
    outRslt: .asciz "%d + 32 = %d\n"

.section .bss //Uninitialized Variables


.text
main:
    //Keep track of where I came from
    push {lr}

    //Number 32
    //mov r5, #32
    ldr r5, =addBy //Load Address
    ldr r5, [r5]   //Load dereferenced address (the value)

    //Prompt user for input
    ldr r0, =outPat
    ldr r1, =outPrmpt
    bl printf

    //Get user input
    ldr r0, =inPat
    ldr r1, =in
    bl scanf

    //Operations
    ldr r1, =in  //Address
    ldr r1, [r1] //Dereferenced address

    add r2, r5, r1 //r2 = r5 + in

    //Store the result
    //str is reversed from ldr:
    //lrd storehere, loadthis
    //str storthis, here
    ldr r3, =rslt //Store address in r3
    str r2, [r3]  //Store value r2 into value location r3 (dereferenced address)

    //Output result
    ldr r0, =outRslt
    ldr r1, =in  //Gets the address of in
    ldr r1, [r1] //Now the value
    

    //Get the result variable from memory
    ldr r2, =rslt //Address
    ldr r2, [r2]  //Value from address
    bl printf

    //return 0
    mov r0, #0;
    
    //Resume where I left off
    pop {pc}
