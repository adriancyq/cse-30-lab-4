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

	int listThree[] = {13, 13};
	int listThreeMajority;

	//Testing on an empty list
	assert(majority_count_ARM(listOne, 0, &listOneMajority) == 0);
	printf("Passed test for empty list.\n");

	//Testing on list with single element 
	assert(majority_count_ARM(listTwo, 1, &listTwoMajority) == 1);
	assert(listTwoMajority == 2);
	printf("Passed test for list with one item.\n");

	int ccount = majority_count_ARM(listThree, 2, &listThreeMajority);
	printf("The count: %d\nThe majority: %d\n", ccount, listThreeMajority);

    return 0;
}
