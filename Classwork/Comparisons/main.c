#include "stdio.h"

int main(int argc, char** argv) {

    int r0 = 50;
    int r2;

    printf( "Enter a number: ");
    scanf("%d", &r0);

    if(r0 < 0) {
        r2 = 60;
    } else {
        r2 = 0;
    }

    printf("r2: %d\n", r2);

    return 0;
}