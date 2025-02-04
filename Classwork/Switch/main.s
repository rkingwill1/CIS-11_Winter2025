.global main
.global rgb
.global clear

.extern wiringPiSetupGpio
.extern pinMode
.extern digitalRead
.extern digitalWrite
.extern delay

.equ PIN_LED, 18
.equ PIN_BUTTON, 16
.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1

.text
main:
    push {lr}

    //Init
    bl wiringPiSetupGpio

    //Pin modes
    mov r0, #PIN_LED
    mov r1, #OUTPUT
    bl pinMode
    mov r0, #PIN_BUTTON
    mov r1, #INPUT
    bl pinMode

    while: # {
        //Get the input before this tick
        mov r0, #PIN_BUTTON
        bl digitalRead
        mov r6, r0

        //Skip if button is not pressed
        cmp r6, #1 
        bne skip
        cmp r5, #0
        bne skip //if(crntState == 1 && ledState == 0) {

        //Exclusive or to swap the state of the button
        //0->1, 1->0
        eor r4, #1 //ledState = !ledState

        mov r0, #PIN_LED
        mov r1, r4
        bl digitalWrite


        skip:

        //Update previous buttone state
        mov r5, r6 //prevState = crntState

        //Add delay
        mov r0, #50
        bl delay


        bal while
    # }


    mov r0, #0
    pop {pc}
