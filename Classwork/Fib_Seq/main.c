#include "stdio.h"

int sumArr(int*, int);

int main(int argc, char** argv) {
    int arr[] = {10, 20, 30, 40, 50};
    int size = 5;
    int sum = sumArr(arr, size);
    printf("sum is %d\n", sum);

    return 0;
}

int sumArr(int *a, int sz) {
    int sum = 0;
    
    for(int i = 0; i < sz; i++) {
        sum = sum + a[i];
        printf("%d + %d\n", sum, a[i]);
    }

    return sum;
}