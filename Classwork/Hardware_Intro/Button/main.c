#include "stdio.h"
#include "wiringPi.h"

#define PIN_BUTTON 18
#define PIN_LED    17

int main(int argc, char** argv) {
    //Setup Gpio
    wiringPiSetupGpio();

    //Set pin modes
    pinMode(PIN_BUTTON, INPUT);
    pinMode(PIN_LED, OUTPUT);

    //Infinite Loop
    while(1) {
        if(digitalRead(PIN_BUTTON) == HIGH) {
            digitalWrite(PIN_LED, HIGH);
        }
        else { 
            digitalWrite(PIN_LED, LOW);
        }
        delay(100);
    }
    return 0;
}