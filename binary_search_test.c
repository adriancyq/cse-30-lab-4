/* ********************************
 * CSE 30 - HW 4
 * ********************************/

#include <stdio.h>
#include "binary_search.h"

int main(int argc, char ** argv) {
    int data[] = {1,2,3,4,5,6,7,8,9,10};
    int data2[] = {10,9,8,7,6,5,4,3,2,1};

    printf("C   Binary Search: %d\n", binary_search(data, 4, 0, 9));
    printf("ARM Binary Search: %d\n", binary_search_ARM(data, 4, 0, 9));
    printf("C   Binary Search: %d\n", binary_search(data2, 9, 0, 4));
    printf("ARM Binary Search: %d\n", binary_search_ARM(data2, 9, 0, 4));
    return 0;
}
