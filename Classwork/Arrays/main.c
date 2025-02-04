#include "stdio.h"

void outputArr(int [], int);

int main(int argc, char** argv) {
    int a[25];

    outputArr(a, 25);

    return 0;


}

void outputArr(int a[], int s) {
    for(int i = 0; i < s; i++) {
        printf("a[%d] = %d\n", i, a[i]);
    }

    return;
}