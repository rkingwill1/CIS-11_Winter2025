#include "stdio.h"
#include "stdbool.h"
#include "wiringPi.h"

#define PIN_LED 18
#define PIN_BUTTON 16

int main(int argc, char** argv) {
    //Init
    wiringPiSetupGpio();

    //Set pin modes
    pinMode(PIN_LED, OUTPUT);
    pinMode(PIN_BUTTON, INPUT);


    //-----MY VERSION-----//
    //On bool
    //bool press = false;
    bool on = false;

    while(1) {
        while(1) {
            if(digitalRead(PIN_BUTTON) == HIGH) {
                printf("Pressed the button\n");
                on = !on;
                break;
            }
        }

        //Change LED state
        digitalWrite(PIN_LED, on);
    }

    //-----HIS VERSION-----//
    int ledState = false;
    int prevState = 0;
    
    while(1) {
        //Gets input before this tick
        int crntState = digitalRead(PIN_BUTTON);

        //If button was pressed this tick, and the light was off, and the previous buton state was off
        if(crntState == 1 && ledState == 0) {
            printf("Pressed the button\n");
            //Change LED state
            ledState = !ledState; 
            digitalWrite(PIN_LED, ledState);
        }

        //Update button state
        prevState = crntState;
    }


    return 0;
}