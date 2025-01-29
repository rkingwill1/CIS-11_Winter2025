#include "stdio.h"

//Function Prototypes
void passByVal(int, int, int);

int main(int argc, char** argv) {
    //Variables
    int a = 123;
    int b = 100;
    int c = 256;

    //Print initial
    printf("Val1: %d\n", a);
    printf("Val2: %d\n", b);
    printf("Val3: %d\n", c);

    //Function call
    passByVal(a, b, c);

    //Print after function call
    printf("Val1: %d\n", a);
    printf("Val2: %d\n", b);
    printf("Val3: %d\n", c);
    printf("End of passByVal fn\n");

    return 0;
}

void passByVal(int a, int b, int c) {
    printf("Pass Value fn\n\n");
    int t = a + b;
    t = t + c;

    printf("Sum: %d\n", t);

    a = a + 1;
    b = b + 2;
    c = c - 3;
}