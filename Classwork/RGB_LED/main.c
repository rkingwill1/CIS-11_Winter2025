#include "stdio.h"
#include "stdbool.h"
#include "wiringPi.h"

#define PIN_R 5
#define PIN_G 6
#define PIN_B 21
#define PIN_BUTTON 12

//Functions
void rgb(int);
void clear();

int main(int argc, char** argv) {
    //Init
    wiringPiSetupGpio();

    //Set pin modes
    pinMode(PIN_R, OUTPUT);
    pinMode(PIN_G, OUTPUT);
    pinMode(PIN_B, OUTPUT);
    pinMode(PIN_BUTTON, INPUT);

    int phase = 0;
    bool on = true;

    while(1) {
        if(digitalRead(PIN_BUTTON) == HIGH) {
            on = true;
        }
        else {
            on == false;
        }

        if(on) {
            rgb(phase); //Sets the color
            printf("Phase %d\n", phase);
            phase = (phase + 1) & 0b111; //Looping 0-7 number
        }

        delay(1000);
    }
}

void rgb(int p) {
    clear();

    //Red
    if(p & 0b100) digitalWrite(PIN_R, HIGH); 
    //Green
    if(p & 0b010) digitalWrite(PIN_G, HIGH); 
    //Blue
    if(p & 0b001) digitalWrite(PIN_G, HIGH); 

    return;
}

void clear() {
    digitalWrite(PIN_R, LOW);
    digitalWrite(PIN_G, LOW);
    digitalWrite(PIN_B, LOW);

    return;
}