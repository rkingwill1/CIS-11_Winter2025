#include "stdio.h"

int main(int argc, char** argv) {
	int in; 	 //Input integer
	int r5 = 32; //Other operation value

	//Prompt user
	printf("%s", "Enter a number: ");

	//Get user input
	scanf("%d", &in);

	//Operations
	int r2 = in + r5;

	//Output result
	printf("%d + 32 = %d\n", in, r2); 

	return 0;

}
