#include "stdio.h"

int main(int argc, char** argv) {
    int input;
    char* outPrmpt = "Enter a number to sum till: ";
    char* inPat = "%d";
    char* outStr = "Your sum is %d\n";

    //Prompt for input
    printf(outPrmpt);
    //Get input
    scanf(inPat, &input);

    //loop addition till n
    int i = 1; //Counter
    int sum = 0;
    while(i <= input) {
        //Add i to sum
        sum = sum + i;
        //Debug output
        printf("i = %d\n", i);
        //Increment counter
        i++;
    }
    //Output the result
    printf(outStr, sum);


    return 0;
}