.global main

//External functions
.extern wiringPiSetupGpio
.extern pinMode
.extern digitalRead
.extern digitalWrite
.extern delay

.equ PIN_BUTTON, 18
.equ PIN_LED,    17
.equ LOW,        0
.equ HIGH,       1
.equ INPUT,      0
.equ OUTPUT,     1

.text

main:
    push {lr}

    //Setup Gpio
    bl wiringPiSetupGpio

    //Set pin modes
    mov r0, #PIN_BUTTON
    mov r1, #INPUT
    bl pinMode
    mov r0, #PIN_LED
    mov r1, #OUTPUT
    bl pinMode

    //Infinite while loop
    while: # {
        //Read the button pin
        mov r0, #PIN_BUTTON
        bl digitalRead
        //Check state of LED pin
        cmp r0, #HIGH //TRUE if LED pin is on
        //digitalWrite parameters
        mov r0, #PIN_LED
        moveq r1, #HIGH //If r0 is high put high into r1
        movne r1, #LOW  //If r0 is low put low into r1
        bl digitalWrite

        bal while
    # }

    mov r0, #0
    pop {pc}
