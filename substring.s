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

    @ Find the length of both strings 
    MOV R0, R10
    BL strlen
    MOV R8, R0 

    MOV R0, R11 
    BL strlen 
    MOV R9, R0 

    @ (your code)

    @ put your return value in r0 here:
    MOV R0, R8
    @-----------------------

    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc

.end

