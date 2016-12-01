/* ********************************
 * CSE 30 - HW 4
 * ********************************/

#include <stdio.h>
#include <assert.h>
#include "majority_count.h"

int main(int argc, char ** argv) {
	int listOne[] = {};
	int listOneMajority;

	int listTwo[] = {2};
	int listTwoMajority;

	int listThree[] = {13, 13, 13, 4};
	int listThreeMajority;

	// Testing on an empty list
	assert(majority_count_ARM(listOne, 0, &listOneMajority) == 0);
	printf("Passed test for empty list.\n");

	// Testing on list with single element 
	assert(majority_count_ARM(listTwo, 1, &listTwoMajority) == 1);
	assert(listTwoMajority == 2);
	printf("Passed test for list with one item.\n");

    // int data[] = {0, 0, 0, 1};
    // int c_majority, arm_majority;
    // int c_count = majority_count(data, 4, &c_majority);
    // int arm_count = majority_count_ARM(data, 4, &arm_majority);

    // printf("C   Majority Count  : %d\n", c_count);
    // printf("C   Majority Element: %d\n", c_majority);
    // printf("ARM Majority Count  : %d\n", arm_count);
    // printf("ARM Majority Element: %d\n", arm_majority);
    return 0;
}
