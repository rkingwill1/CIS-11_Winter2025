#include "stdio.h"

int main(int argc, char** argv) {
    //Variables
    int r0, r1, r2, r3, r4, r5, r6, r7, r8, r9;
    int w, l, a;
    //Prompt user to input width
    printf("Enter the width: ");
    //Get width from user
    scanf("%d", &w);
    //Prompt user for width
    printf("Enter the length: ");
    //Get width from user
    scanf("%d", &l);

    //Load the registers
    r1 = l;
    r2 = w;

    //Validate data
    if(r1 < 0) {
        printf("Width cannot be negative");
        return 0;
    }
    if(r2 < 0) {
        printf("Length cannot be negative");
        return 0;
    }

    //Operations
    r3 = w * l;
    //Store result
    a = r3;

    //Check if square
    if(r1 == r2) 
        goto square;
    else { //Output results
        printf("Calculated area: %d\n", a);
        return 0;
    }
    

square:
    printf("Your shape is a square!\n");
    printf("Calculated area %d\n", a);

    return 0;
}