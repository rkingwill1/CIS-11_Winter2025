.global main

.data
    out: .asciz "%d\n"

.text
main:
    stmdb sp!, {lr} //Same as push {lr}
    
    mov r0, #25
    //Preindexing to store value
    //adds the offset which is -4 to the address in sp first, then it accesses that new address
    //The ! saves the new address into sp. You don't always need to do that
    str r0, [sp, #-4]! //Save r0 into the stack and write the new stack address to the sp

    ldr r0, =out

    //Postindexing to load the value of 25
    //Loads from sp first, it then adds by the offest (r), then it writes back that new address into sp (no choice)
    ldr r1, [sp], #4
    bl printf

    //Load multiple increment after
    ldmia sp!, {pc} //Same as pop {pc}
