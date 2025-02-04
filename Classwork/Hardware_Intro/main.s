.global main

//External functions
.extern wiringPiSetupGpio
.extern pinMode
.extern digitalWrite
.extern delay

//Constants
.equ PIN_LED, 21
.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1

.section .data //Initialized data

.section .rodata //Readonly data

.text
main:
    push {lr}

    //Setup Gpio
    bl wiringPiSetupGpio

    //Set pinmode
    mov r0, #PIN_LED //Pin 21
    mov r1, #OUTPUT  //Output mode = 1
    bl pinMode

    //on boolean
    mov r4, #0 //bool on = false;

    //While loop
    while: # {
        cmp r4, #1
        //Turn pin on
        beq on
        bne off
        on: # {
            //Turn on LED pin with digitalWrite
            mov r0, #PIN_LED
            mov r1, #HIGH
            bl digitalWrite
            //Toggle bool false
            mov r4, #0
            bal delayLabel

        # }
        off: # {
            //Turn off the pin
            mov r0, #PIN_LED
            mov r1, #LOW
            bl pinMode
            //Toggle bool true
            mov r4, #1

        # }

        delayLabel: # {
            mov r0, #250
            bl delay
        
        # }

        bal while
    # }

    mov r0, #0
    pop {pc}
