.syntax unified


.data 


.text


.align 8
.global binary_search_ARM
.func binary_search_ARM, binary_search_ARM
.type binary_search_ARM, %function

binary_search_ARM:

    @ Binary search in a sorted array 

    @ Parameters:
    @ R0: * data
    @ R1: toFind
    @ R2: start
    @ R3: end

    @ Dictionary of Registers 
    @ R4: mid
    @ R5: data[mid]

    @ We need to save away a bunch of registers
    push {r4-r11, ip, lr}

    @ Store all parameters in the stack
    SUB SP, SP, #16
    STR R0, [SP]  @store *data into stack
    STR R1, [SP, #4]  @store toFind in stack
    STR R2, [SP, #8]   @store start in stack
    STR R3, [SP, #12]   @store end in stack

    @ Midpoint 
    SUB R4, R3, R2 
    ASR R4, R4, #1          
    ADD R4, R4, R2          @ mid = start + (end - start)/2

    @ Terminating condition: if start > end 
    @compare start and end
    CMP R2, R3

    @ branch to false declaration to make return value =1
    BGT falseDec

    @ data[mid]
    LDR R5, [R0, R4, LSL #2]

    @data[mid] == toFind
    CMP R5, R1
    MOVEQ R0, R4        @ return mid
    BEQ foundElement

    @ else if data[mid] > toFind
    SUBGT R3, R4, #1

    @ else if data[mid] < toFind
    ADDLT R2, R4, #1

    BL binary_search_ARM
    B foundElement

@make return value -1
falseDec:
	MOV R0, #-1

foundElement:
    ADD SP, SP, #16


    @ Remember to restore the stack pointer before popping!
    @ This handles restoring registers and returning
    pop     {r4-r11, ip, pc}
    
.endfunc

.end


