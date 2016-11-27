.syntax unified
.data 


.text

.align 8
.global str_to_int
.func str_to_int, str_to_int
.type str_to_int, %function

str_to_int:

	@ Parameters:
	@ R0: char * str 
	@ R1: int * dest 

	@ Dictionary of registers
	@ R2: length of string 
	@ R3: index in for loop 
	@ R4: char at index 
	@ R5: sum
	@ R6: digit 
	@ R10: str 
	@ R11: dest 

    @ We need to save away a bunch of registers
    push {r4-r11, ip, lr}

    @ Store the arguments elsewhere 
    MOV R10, R0
    MOV R11, R1 

    @ Get the length of the string 
    MOV R0, R10
    BL strlen
    MOV R2, R0 

    @ For loop to iterate through string 
    MOV R3, #0 

    @ Initialize sum 
    MOV R5, #0

traverseString:
	
	@ index < strLength 
	CMP R3, R2
	BGE finishedTraversing 

	@ Grab char at specified index 
	LDRB R4, [R10, R3]

	@ TODO Check that char falls in range of ASCII digits

	@ Convert char to int 
	SUB R6, R4, #48

	@ Add to sum
	MOV R7, #10
	MUL R5, R5, R7
	ADD R5, R5, R6

	@ Go to next element 
	ADD R3, R3, #1
	B traverseString


finishedTraversing:
	
	@ Put sum in dest
	STR R5, [R11]

	MOV R0, #1

    @ This handles restoring registers and returning
    pop {r4-r11, ip, pc}

.endfunc

.end


