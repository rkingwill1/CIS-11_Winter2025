.global addVal
.func addVal

//uint32_ addVal(uint32_t a, uint32_t b);

addVal:
    push {lr}

    add r2, r0, r1
    mov r0, r2


    pop {pc}
    