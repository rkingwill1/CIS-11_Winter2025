.global main

.section .data //Initialized Variables

.section .rodata //Readonly Data

.section .bss //Uninitialized Variables

.text
main:
    //Keep track of where I came from
    push {lr}


    //Resume where I left off
    pop {pc}
