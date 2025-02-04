#include "stdio.h"
#include "wiringPi.h"
#include "stdbool.h"

#define PIN_LED 21

int main(int argc, char** argv) {
    //Setup Gpio
    wiringPiSetupGpio();

    //Set the pin mode
    pinMode(PIN_LED, OUTPUT); //Set pin 21 to output

    //Program
    bool on = false;

    //While the program is on forever
    while(true){
        if(on){
            //Turn on the pin
            digitalWrite(PIN_LED, HIGH); //Turn pin 21 on(HIGH)
            on = false;
        }
        else {
            //Turn off the pin
            digitalWrite(PIN_LED, LOW); //Turn pin 21 off(LOW)
            on = true;
        }

        delay(250); //Delay in milliseconds

    }


    return 0;
}

