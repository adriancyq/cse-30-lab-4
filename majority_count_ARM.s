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

    @ Check if list is empty: if (len == 0)
    CMP R1, #0
    BEQ emptyList

    @ Store parameters elsewhere 
    MOV R9, R0 										@ arr 
    MOV R10, R1 									@ len 
    MOV R11, R2 									@ result 

    @ Check if list only has one element: if (len == 1)
    CMP R10, #1 

    @ Get the only element in the array and store in result 
    LDREQ R8, [R9] 									@ arr[0]
    STREQ R8, [R11] 								@ *result = arr[0]
    BEQ singleElement 


@ Return 0 if list is empty 
emptyList:
	MOV R0, #0
	B end 

@ Single element in array, count is 1
singleElement:
	MOV R0, #1
	
end:
    @ This handles restoring registers and returning
    pop {r4-r11, ip, pc}

.endfunc

.end


