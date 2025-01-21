#include "stdio.h"

int main(int argc, char** argv) {
    int input;
    char* outPrmpt = "Enter a number to sum till: ";
    char* inPat = "%d";
    char* outStr =  "Your sum is %d\n";
    char* debug = "i = %d\n";

    //Prompt user
    printf(outPrmpt);
    //Get input
    scanf(inPat, &input);

    //Loop addtition till n
    int sum = 0;
    for(int i = 1; i <= input; i++) {
        sum = sum + i;
        printf(debug, i);
    }

    //Output result
    printf(outStr, sum);

    return 0;
}