#include "stdio.h"
#include "time.h"
#include "stdlib.h"

void outArr(int*, int n);
void input(int*, int n);
void bubbleSort(int*, int);

int main(int argc, char** argv) {
    int len = 5;
    int arr[len];

    //Seed random
    srand(time(0));

    //Input
    input(arr, len);

    //Sort
    bubbleSort(arr, len);

    //output
    printf("-----Sorted array-----\n");
    outArr(arr, len);

    return 0;
}

void outArr(int* a, int n) {
    for(int i = 0; i < n; i++) {
        printf("%d\n", a[i]);
    }
    printf("\n");

    return;
}

void input(int* a, int n) {
    // for(int i = 0; i < n; i++) {
    //     printf("Enter a[%d]: ", i);
    //     scanf("%d", a[i]);
    // }

    for(int i = 0; i < n; i++) {
        a[i] = rand() % 90 + 10;
    }
}

void bubbleSort(int *a, int n) {
    int x = n - 1;
    for(int i = 0; i < x; i++) {
        for(int j = 0; j < x; j++) {
            if(a[j] > a[j+1]) {
                int temp = a[j];
                a[j] = a[j+1];
                a[j+1] = temp;
            }
        }
    }
}