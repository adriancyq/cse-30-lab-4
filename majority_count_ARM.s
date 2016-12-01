.syntax unified
.data 
.text
.align 8



@ count_ARM: 
@ Count the number of times "target" appears in the array.

@ Parameters:
@ R0: int * arr 
@ R1: int len 
@ R2: int target 

@ Dictionary of Parameters:
@ R4: index of for loop
@ R10: arr[i]
@ R11: return value, ret_count

@ Returns:
@ R0: int, the number of times "target" appears in "arr"

.global count_ARM
.func count_ARM, count_ARM
.type count_ARM, %function

count_ARM:
    
    @ Save caller's registers on the stack
    push {r4-r11, ip, lr}
    
    @ index of for loop
    MOV R4, #0

    @ Place return value in R11 
    MOV R11, #0

@ Iterate through section of array to see if any elements match target
forLoop:
	CMP R4, R1 					@ i < len
	BGE finishedCounting

	@ Grab the element in specified index 
	LDR R10, [R0, R4, LSL #2]

	@ Compare element with target: arr[i] == target 
	CMP R10, R2 
	ADDEQ R11, R11, #1 			@ ret_count++
	ADD R4, R4, #1				@ index++
	B forLoop

@ Looped through desired section of array
finishedCounting:
	MOV R0, R11 				@ Return ret_count

    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc



@ majority_count_ARM:
@ Determine the majority element in the array. Arrays of length 0 have no 
@ majority element.

@ Parameters
@ R0: int * arr
@ R1: int len
@ R2: int * result, the location at which the value of the majority
@       element should be stored

@ Dictionary of Registers:
@ R4: retval of left majority count 
@ R5: len /2 
@ R6: &left majority 
@ R7: &right majority 
@ R8: arr[0], retval of right majority count 
@ R9: arr 
@ R10: len 
@ R11: result 

@ Returns:
@ R0: the count of the majority element in the array. 0 if no majority 
@       element.
.global majority_count_ARM
.func majority_count_ARM, majority_count_ARM
.type majority_count_ARM, %function

majority_count_ARM:

    @ We need to save away a bunch of registers
    push {r4-r11, ip, lr}

    @ Check if list is empty 
    CMP R1, #0
    BEQ emptyList

    @ Store parameters elsewhere 
    MOV R9, R0 				@ arr 
    MOV R10, R1 			@ len 
    MOV R11, R2 			@ result 

    @ Base case: Check if list only has one element 
    CMP R10, #1 

    @ Get the only element in the array and store in result 
    LDREQ R8, [R9] 			@ arr[0]
    STREQ R8, [R11] 		@ *result = arr[0]
    
	SUB SP, SP, #8
    BEQ singleElement 

	@ Allocate space on the stack for left and right majority 

	@ Calculate len/2
	ASR R5, R10, #1 		@ len / 2

	@ LEFT: majority_count(arr, len/2, &left_majority);
	MOV R0, R9  			@ arr 
	MOV R1, R5		 		@ len/2
	MOV R2, SP 				@ &left_majority 
	BL majority_count_ARM 
	MOV R4, R0 				@ retval of left majority count 

	@ RIGHT: majority_count(arr+len/2, len-len/2, &right_majority);
	LSL R5, R5, #2
	ADD R0, R9, R5
	SUB R1, R10, R5 
	ADD R2, SP, #4
	BL majority_count_ARM
	MOV R8, R0 

	@ Check if there was a left majority 
	CMP R4, #0
	BEQ noMajority 

	@ Check if there was a right majority 
	CMP R8, #0
	BEQ noMajority 

	@ Get the count of left majority 
	MOV R0, R9
	MOV R1, R10 
	MOV R2, R4 
	BL count_ARM 

	@ Check if left majority occurs in more than half the elements 
	CMP R0, R5
	STRGT R0, [R11]
	BGT end 

	@ Get the count of right majority 
	MOV R0, R9
	MOV R1, R10 
	MOV R2, R8
	BL count_ARM

	@ Check if right majority occurs in more than half the elements 
	CMP R0, R5
	STRGT R0, [R11]
	BGT end 

@ Return 0 if no majority 
noMajority: 
	MOV R0, #0 
	B end 

@ Return 0 if list is empty 
emptyList:
	MOV R0, #0
	B end 

@ Single element in array, count is 1
singleElement:
	MOV R0, #1

	@ Deallocate stack 
    ADD SP, SP, #8
end:
    @ This handles restoring registers and returning
    pop {r4-r11, ip, pc}

.endfunc

.end


