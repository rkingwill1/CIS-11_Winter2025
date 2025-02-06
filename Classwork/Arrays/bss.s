.global main //Try readelf -x .bss a.out

.section .bss
    .align 4
    a: .space 10485760

.text
main:
    push {lr}

    pop {pc}
