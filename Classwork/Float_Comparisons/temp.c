#include "stdio.h"
#include "math.h"

int main(int argc, char** argv) {
    float a = 1.0000001f;
    float b = 1.0000002f;
    if(a == b) {
        printf("equal\n");
    }
    else {
        printf("not equal\n");
    }

    float delta = 0.00001f;
    //If their difference is smaller than some delta say they are equal
    if(fabs(a - b) < delta) {
        printf("Equal within delta\n");
    }
    else {
        printf("Not equal within the delta\n");
    }

    return 0;
}