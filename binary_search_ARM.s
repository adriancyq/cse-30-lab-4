.syntax unified

/* You can put constants in the .data section. Look up how to do it on your own,
 * or come ask us if you're curious!*/
.data 


.text

/*int binary_search_ARM(int * data, int toFind, int start, int end)*/
/*Note that you return your value in r0*/

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

    @data[mid] == toFind
    STR R1, [SP]
    
  	
    STR R2, [sp, #4]

    SUB R6, R2, R1
    ASR R6, R6, #1
    ADD R6, R6, R1

    LDR R5, [R0, R6, LSL#2]

    CMP R5, R3
    MOVEQ R0, R6
    BEQ return 

    SUBGT R2, R6, #1

    ADDLT R1, R6, #1

    BL binary_search_ARM
    B return

    falseDec:
    	MOV R0, #-1
    return:
    /* You should probably do something here */

    mov r0, #0
    @ Remember to restore the stack pointer before popping!
    @ This handles restoring registers and returning
    pop     {r4-r11, ip, pc}

.endfunc

.end


