#include "stdio.h"
#include "stdlib.h" //rand function
#include "time.h"   //srand, time function

int main(int argc, char** argv) {
    //Seed rand
    srand(time(0));

    for(int i = 0; i < 20; i++) {
        int a = rand() % 90 + 10;
        printf("%d\n", a);
    }

    return 0;
}