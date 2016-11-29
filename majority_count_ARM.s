.syntax unified

.data 


.text

.align 8
.global majority_count_ARM
.func majority_count_ARM, majority_count_ARM
.type majority_count_ARM, %function

majority_count_ARM:
    @ We need to save away a bunch of registers
    push    {r4-r11, ip, lr}
    @ May want to decrement stack pointer for more space

    @int *arr = R0
    @int len = R1
    @int *result = R2

    @SUB SP, SP, #16 	allocated 16 bytes to stack
    @STR R0, [SP] 		store R0 in stack pointer
    @STR R1, [SP, #4]	store R1 in stack pointer
    @STR R2, [SP, #8]	store R2 in stack pointer

    @CMP R1, #0 		len == 0
    @MOVEQ R0, #0 		return 0 because len == 0
    @BEQ end 		branch to return

    @CMP R1, #1 		compare len to 1
    @BEQ rightMajority 	branch to rightMajority if equal to 1
    @BNE count		branch to counterFunc if not equal to 1

@rightMajority:
	
	@CMP R1, #0
	@BEQ end
	@LDR R2, [R0]
	@CMP R1, #0
	@STRNE R2, [R1]
	@MOV R0, #1
	@B end 

@count:
	
	@LDR R0, [SP]
	@LDR R3, [SP, #4]
	@LSR R3, R3, #1
	@ADD R1, SP, #12

	@BL majority_count_ARM
	@STR R0, [SP, #20]  		PROBABLY WRONG NUMBER OF bytes
	@MOV R7, R0

	@LDR R0, [SP]
	@LDR R3, [SP, #4]
	@LSR R4, R3, #1
	@ADD R0, R0, R4
	@SUB R3, R3, R4
	@ADD R1, SP, #16

	@BL majority_count_ARM
	@STR R0, [SP, #24]
	@MOV R6, R0

	@CMP R7, #0
	@BEQ majorityfinder 			
	@LDR R0, [SP]
	@LDR R3, [SP, #4]
	@LDR R1, [SP, #12]

	@B rightcount			

@rightmajority_return:

	@POP {R4-R7}
	@MOV R5, R0
	@CMP R0, R4
	@BLE majorityfinder

	@MOV R0, R5

	@LDR R5, [SP, #8]

	@CMP R5, #0
	@BEQ end
	@STR R1, [R5]
	@B end

@majorityfinder:
	@CMP R6, #0
	@BEQ end
	@LDR R0, [SP]
	@LDR R3, [SP, #4]
	@LDR R1, [SP, #16]

	@B leftcount

@leftmajority_return:

	@POP {R4-R7}
	@MOV R5, R0
	@CMP R0, R4
	@MOVLE R0, #0
	@BLE end

	@MOV R0, R5
	@LDR R5, [SP, #8]

	@CMP R5, #0
	@BEQ end
	@STR R1, [R5]
	@B end

@rightcount:

	@PUSH {R4-R7}
	@MOV R5, #0
	@MOV R6, #0

@loop1:

	@CMP R5, R3
	@MOVEQ R0, R6
	@BEQ rightmajority_return
	@LDR R4, [R0, R5, LSL #2]
	@CMP R4, R1
	@ADDEQ R6, R6, #1
	@ADD R5, R5, #1

	@B loop1

@leftcount:
	
	@PUSH {R4-R7}
	@MOV R5, #0
	@MOV R6, #0

@loop2:
	
	@CMP R5, R3
	@MOVEQ R0, R6
	@BEQ leftmajority_return
	@LDR R4, [R0, R5, LSL #2]
	@CMP R4, R1
	@ADDEQ R6, R6, #1
	@ADD R5, R5, #1

	@B loop2


    @ Remember to restore your stack pointer before popping!
@end:
	@ADD SP, SP, #32 
    
    @ This handles restoring registers and returning
    pop     {r4-r11, ip, pc}

.endfunc

.end


