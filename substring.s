.syntax unified

.text

.align 8
.global substring
.func substring, substring
.type substring, %function

substring:

    @ Save caller's registers on the stack
    push {r4-r11, ip, lr}

    @ Parameters:
    @ R0: char * str1
    @ R1: char * str2 
    @ 
    @ Dictionary of Registers:
    @ R2: index of shorter string 
    @ R3: index of longer string 
    @ R4: letter of shorter string 
    @ R5: letter of longer string 
    @ R6: the shorter string 
    @ R7: the longer string 
    @ R8: length of first string (shorter)
    @ R9: length of second string (longer)
    @ R10: str1
    @ R11: str2
    @-----------------------

    @ Store arguments elsewhere
    MOV R10, R0
    MOV R11, R1 

    @ Find the length of first string
    MOV R0, R10
    BL strlen
    MOV R8, R0 

    @ Find the length of the second string 
    MOV R0, R11 
    BL strlen 
    MOV R9, R0 

    @ Check if the first one is shorter than the second one
    CMP R8, R9 

    @ First one is shorter
    MOVLT R6, R10
    MOVLT R7, R11

    @ Switch lengths
    MOVGE R6, R8
    MOVGE R8, R9
    MOVGE R9, R6 

    @ Second one is shorter or equal to the first 
    MOVGE R6, R11 
    MOVGE R7, R10

    @ Adjust for 0 index vs 1 index in length 
    SUB R6, R6, #1 
    SUB R7, R7, #1 

    @ Index to go through each char in the longer string 
    MOV R2, #0
    MOV R3, #0

@ Go through each letter to see if they match 
iterateThroughString:
    
    @ Check that we have not reached end of longer string 
    CMP R3, R7 
    BEQ noSubstring

    @ Grab the next letter of the shorter string 
    LDRB R4, [R6, R2, LSL #1]

    @ Grab the next letter of the longer string 
    LDRB R5, [R7, R3, LSL #1]

    @ Compare the two chars
    CMP R4, R5

    @ If not equal, check the next char in longer string 
    ADDNE R3, R3, #1
    BNE iterateThroughString

    @ Chars equal: Check that we are not done with the smaller string 
    CMPEQ R2, R8

    @ Go to next char in smaller string 
    ADDLT R2, R2, #1
    ADDLT R3, R3, #1

    BLT iterateThroughString

    MOVEQ R0, #1
    B end 

noSubstring:
    MOV R0, #0

end: 

    @-----------------------
    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc

.end