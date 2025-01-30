#include "stdio.h"

//Prototypes
void passByRef(int*, int*, int*);

int main(int argc, char** argv) {
    int val1 = 123,
        val2 = 456,
        val3 = 256;

    printf("Before passByRef function\n");
    printf("val1: %d\n", val1);
    printf("val2: %d\n", val2);
    printf("val3: %d\n", val3);


    return 0;
}