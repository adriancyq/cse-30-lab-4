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

    @ Shorter string in R6, longer string in R7
    MOVLT R6, R10
    MOVLT R7, R11
    MOVGE R6, R11
    MOVGE R7, R10

    @ Shorter string length assigned to R8
    MOVGE R0, R9
    MOVGE R9, R8
    MOVGE R8, R0

    @ needleIndex == needleLength - 1
    SUB R8, R8, #1

    @ Iterate through longer string
    MOV R2, #0
    MOV R3, #0

traverseHaystack:

    @ Iterate through every char
    CMP R3, R9
    
    BEQ endOfHaystack

@ Grab chars from both strings 
    LDRB R4, [R8, R2]
    LDRB R5, [R9, R3]

    @ See if two chars are equal 
    CMP R4, R5 
    ADD R3, R3, #1
    BNE traverseHaystack

    @ two chars are equal: all chars in needle match haystack 
    CMP R2, R8
    BEQ foundSubstring

    @ two chars are equal: havent yet matched all chars in needle
    ADD R2, R2, #1
    B traverseHaystack

endOfHaystack:
    MOV R0, #0
    B end 

foundSubstring:
    MOV R0, #1

end:    
    @-----------------------
    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc

.end
