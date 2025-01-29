#include "stdio.h"

//Function Prototypes
int abs(int);
int getInput();
int isqrt(int);

int main(int argc, char** argv) {
    int input;

    //Get input
    input = getInput();

    //Calculate
    int guess = isqrt(input);

    //Output results
    printf("Approx sqrt of %d is %d\n", input, guess);

    return 0;
}

int getInput() {
    int r1;

    //Validata input
    do {
        //Prompt for input
        printf("Enter a number to approximate the square root: ");
        //Get input
        scanf("%d", &r1);
    } while(r1 <= 0);

    return r1;
}

int abs(int x) {
    return (x < 0) ? -x : x;

}

int isqrt(int in) {
    //Guess and previous guess
    int guess = in >> 1; //Guess divided by 2
    int prev; //To determine if we converge

    //Counter
    int i = 0;

    //Formula: x_(n+1) = 1/2 (x_n + input / x_n)
    do {
        prev = guess;
        int t = in / guess; //input / x_n
        t = guess + t; //(x_n + input / x_n) -> x_n + t
        t = t >> 1; // 1/2(x_n + input / x_n) -> 1/2(t)
        guess = t;

        printf("guess #%d: %d\n", i, guess);

        i++;
    } while(abs(guess - prev) > 0);

    return guess;
}