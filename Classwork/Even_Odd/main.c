#include "stdio.h"

int main(int argc, char** argv) {
    //Variables
    int r0, r1, r2, r3, r4; //Registers
    int num;                //Number to be checked
    char* prmpt = "Enter a number: ";
    char* inPat = "%d";
    char* outEven = "Your number %d is even.\n";
    char* outOdd = "Your number %d is odd.\n";
    

    //Manage inputs
    //Prompt user
    printf(prmpt);
    //Get input
    scanf(inPat, &num);

    //Test the number
    if((num & 1) == 0) {
        printf(outEven, num);
    } else {
        printf(outOdd, num);
    }


    return 0;
}
