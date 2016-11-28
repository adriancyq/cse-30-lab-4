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
	@ R1: sign
	@ R2: length of string 
	@ R3: index in for loop 
	@ R4: char at index 
	@ R5: sum
	@ R6: digit 
	@ R7: charAt >= '0'
	@ R8: charAt <= '9'
	@ R9: charAt is valid 
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
    MOV R3, #0 	@ Index = 0

    @ Initialize sum and sign 
    MOV R5, #0
    MOV R1, #1

traverseString:
	
	@ index < strLength 
	CMP R3, R2
	BGE finishedTraversing 

	@ Grab char at specified index 
	LDRB R4, [R10, R3]

	@ Check if first char is negative
	CMP R3, #0 		@ index == 0
	CMPEQ R4, #45 	@ charAt == '-'
	MOVEQ R1, #-1
	ADDEQ R3, R3, #1
	BEQ traverseString

	@ Reset comparison registers 
	MOV R7, #0
	MOV R8, #0
	MOV R9, #0

	@ if (charAt >= '0' && charAt <= '9')
	CMP R4, #48  @ charAt >= '0'
	MOVGE R7, #1 @ true

	CMP R4, #57  @ charAt <= '9'
	MOVLE R8, #1

	@ Check that char falls in range of ASCII digits
	AND R9, R7, R8
	CMP R9, #1
	BNE invalidString

	@ Convert char to int 
	SUB R6, R4, #48

	@ Add to sum
	MOV R7, #10
	MUL R5, R5, R7
	ADD R5, R5, R6

	@ Go to next element 
	ADD R3, R3, #1
	B traverseString

@ Looked through entire string
finishedTraversing:
	
	@ get correct signage 
	MUL R5, R5, R1
	
	@ Put sum in dest
	STR R5, [R11]

	@ Return 1 on success
	MOV R0, #1
	B end 

@ String contains characters that were not in range of ASCII digits
invalidString:

	@ Return 0 on failure
	MOV R0, #0

end:

    @ This handles restoring registers and returning
    pop {r4-r11, ip, pc}

.endfunc

.end


