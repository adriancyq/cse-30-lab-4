.syntax unified


.data 


.text


.align 8
.global binary_search_ARM
.func binary_search_ARM, binary_search_ARM
.type binary_search_ARM, %function

binary_search_ARM:
    @ We need to save away a bunch of registers
    push    {r4-r11, ip, lr}
    @ May need to decrement stack pointer for more stack space
    SUB SP, SP, #8

    @compare start and end
    CMP R1, R2

    @branch to false declaration to make return value =1
    BGT falseDec

    @store stack pointer in R1
    STR R1, [SP]

    @store second 4 bytes of SP in R2
    STR R2, [sp, #4]

    @int mid = start + (end - start)/2;
    @int mid = R6
    SUB R6, R2, R1
    ASR R6, R6, #1
    ADD R6, R6, R1

    @data[mid] == toFind
    LDR R5, [R0, R6, LSL#2]

    @data[mid] > toFind
    CMP R5, R3
    MOVEQ R0, R6
    BEQ return 

    @if greater than subtract 1
    SUBGT R2, R6, #1

    @if less than add 1
    ADDLT R1, R6, #1

    BL binary_search_ARM
    B return

    @make return value -1
    falseDec:
    	MOV R0, #-1
    @return 0
    return:
    	MOV R0, #0
    @ Remember to restore the stack pointer before popping!
    @ This handles restoring registers and returning
    pop     {r4-r11, ip, pc}

.endfunc

.end


