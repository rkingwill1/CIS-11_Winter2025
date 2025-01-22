#include "stdio.h"

int main(int argc, char** argv) {
    int input;
    int sum, avg;
    char* prompt = "Enter a positive number: ";
    char* inPat = "%d";
    char* outRes = "Average: %d\n";

    //Prompt for inputs (5 times)
    for(int i = 0; i < 5; i++) {
        //Data validation
        do {
            printf(prompt);
            scanf(inPat, &input);
        } while(input < 0);

        //Adding input to sum
        sum = sum + input;
    }

    //Divide by 5 (multiply by .2)
    avg = sum * 0x334; //.2 = .001100110011 = 1100110011*2^12 = 0x334

    //Shift the average 12 digits (in bin)
    avg = avg >> 12;

    printf(outRes, avg);

    return 0;
}