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
    MOVLT R0, #1

    @ Second one is shorter
    MOVGT R0, #0


    @ put your return value in r0 here:
    @MOV R0, R8
    @-----------------------

    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc

.end