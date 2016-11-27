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
    @ R4: letter of shorter string 
    @ R5: letter of longer string 
    @ R6: the shorter string 
    @ R7: the longer string 
    @ R8: length of first string
    @ R9: length of second string
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

    @ Second one is shorter or equal to the first 
    MOVGE R6, R11 
    MOVGE R7, R10

    @ Grab the first letter of the shorter string 
    LDR R0, [R6]

@ Go through each letter to see if they match 
@iterateThroughString:
    




    @ put your return value in r0 here:
    @MOV R0, R8
    @-----------------------

    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc

.end