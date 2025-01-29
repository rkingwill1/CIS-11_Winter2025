#include "stdio.h"

//Function prototypes
int factorial(int);

int main(int argc, char** argv) {
    //Variables
    int n;

    do {
        //Prompt for input 
        printf("Enter a number from 1-12: ");
        //Get input
        scanf("%d", &n);
    } while(n <= 0 || n > 12);

    //Do factorial
    n = factorial(n);

    //Output
    printf("The factorial is %d\n", n);

    return 0;
}

int factorial(int n) {
    if(n == 0) {
        return 1;
    }
    
    int t = n - 1;
    t = factorial(t);
    return n * t;
}
