/* ********************************
 * CSE 30 - HW 3
 * ********************************/

#include <stdio.h>
#include "substring.h"

int main() {
    	printf("substring: %d.\n", substring("hello", "hi"));
    	printf("substring: %d.\n", substring("hello", "he"));
    	printf("substring: %d.\n", substring("he", "hello"));
	return 0;
}
