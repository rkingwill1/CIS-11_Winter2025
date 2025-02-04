.global main
.global rgb
.global clear

.extern wiringPiSetupGpio
.extern pinMode
.extern digitalRead
.extern digitalWrite
.extern delay

.equ PIN_R, 5
.equ PIN_G, 6
.equ PIN_B, 12
.equ PIN_BUTTON, 21
.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1

.text
main: 
    push {lr}

    //Init
    bl wiringPiSetupGpio

    //Set pin modes
    mov r0, #PIN_R
    mov r1, #OUTPUT
    bl pinMode
    mov r0, #PIN_G
    mov r1, #OUTPUT
    bl pinMode
    mov r0, #PIN_B
    mov r1, #OUTPUT
    bl pinMode
    mov r0, #PIN_BUTTON
    mov r1, #INPUT
    bl pinMode

    //Initialize status variables
    mov r4, #0 //int phase = 0;
    mov r5, #0 //bool on = false;

    //Infinite while
    while: # {
        mov r0, #PIN_BUTTON
        bl digitalRead

        //Check if button is on
        cmp r0, #HIGH //If(digitalRead(PIN_BUTTON) == HIGH) {
        moveq r5, #1  //on = true;
        movne r5, #0  //on = false; }

        cmp r5, #0 //if(!on) {
        beq skip

        //Move phase to r0 for rgb call
        mov r0, r4
        bl rgb

        //Updata phase
        add r4, #1
        and r4, #0b111

        skip:

        //Delay 1 second
        mov r0, #1000
        bl delay

        bal while
    # }




    mov r0, #0
    pop {pc}

rgb:
    push {r4, lr}
    mov r4, r0 //Keep phase in r4
    bl clear //Clear led

    //Red
    tst r4, #0b100
    movne r0, PIN_R
    movne r1, #HIGH
    blne digitalWrite
    //Green
    tst r4, #0b010
    movne r0, PIN_G
    movne r1, #HIGH
    blne digitalWrite
    //Blue
    tst r4, #0b001
    movne r0, PIN_B
    movne r1, #HIGH
    blne digitalWrite

    pop {r4, pc}

clear:
    push {lr}

    mov r0, #PIN_R
    mov r1, #LOW
    mov digitalWrite
    mov r0, #PIN_R
    mov r1, #LOW
    mov digitalWrite
    mov r0, #PIN_R
    mov r1, #LOW
    bl digitalWrite

    pop {pc}
