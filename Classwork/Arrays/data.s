.global main //Try readelf -x .data a.out

.section .data
    .align 4
    a: .space 10485760

.text
main:
    push {lr}

    pop {pc}
    