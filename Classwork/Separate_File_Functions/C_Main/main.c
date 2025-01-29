#include "stdio.h"
#include "stdint.h"

//External file
extern uint32_t addVal(uint32_t a, uint32_t b);

int main(int argc, char** argv) {
    uint32_t a, b, c;
    a = 4;
    b = 1;
    
    c = addVal(a, b);

    printf("a = %d\n", a);
    printf("b = %d\n", b);
    printf("c = %d\n", c);

    return 0;
}
