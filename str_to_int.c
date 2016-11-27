#include <string.h>

int str_to_int(char * str, int * dest)
{

	int strLength;
	int index;
	int sum = 0;
	int digit;
	int sign = 1;
	char charAt;

	/* Get the length of the string */
	strLength = strlen(str);

	/* Iterate through each character in the string */
	for (index = 0; index < strLength; index++) {

		/* Grab the char at specified index */
		charAt = str[index];

		/* Check if the first char is a negative sign */
		if (index == 0 && charAt == '-') {
			sign = -1;
			continue;
		}

		/* Check that char falls within the range of ascii digits */
		if (charAt >= '0' && charAt <= '9') {

			/* Convert char to digit */
			digit = charAt - '0';

			/* Add to sum */
			sum = sum * 10;
			sum = sum + digit;
		}

		/* Char is not a digit */
		else {
			return 0;
		}
	}

	/* Return the converted int */
	sum = sum * sign;
	*dest = sum;
	return 1;
}