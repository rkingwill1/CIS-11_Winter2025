#include "stdio.h"

//Function Prototypes
int multBy5(int);
int getInput();
void output(int, int);

int main(int argc, char** argv) {
    int r3, r4;

    //Get input
    r4 = getInput();

    //Mult by 5
    r3 = multBy5(r4);

    //Output result
    output(r4, r3);

    return 0;
}

int multBy5(int a) {
    int t = a;
    //Mult by 4
    a = a << 2;
    //Add the 5th
    a += t;

    return a;
}

int getInput() {
    int r1;

    //Prompt input
    printf("Enter a number: ");
    //Get input
    scanf("%d", &r1);

    return r1;
}

void output(int in, int res) {
    printf("%d x 5 = %d\n", in, res);
}