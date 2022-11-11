;=================================================

; 
;=================================================

; test harness
.orig x3000

AND R0, R0, #0          ;clears up r0

LD R4, STACK_BOT
LD R5, STACK_TOP
LD R6, STACK_TOS

LD R1, SUB_STACK_PUSH    

LD R2, COUNTER

PUSHING_STACK_A
    ADD R6, R6, #1  ;move TOS ptr (xA000 SHOULD BE EMPTY, STORE VALS IN THE ADDRESSES AFTER)
    
    GETC
    OUT
    
    ADD R0, R0, #-12
    ADD R0, R0, #-12
    ADD R0, R0, #-12
    ADD R0, R0, #-12
    
    JSRR R1
    
    ADD R2, R2, #-1
    BRp PUSHING_STACK_A
END_PUSHING_STACK_A


GETC
OUT

LD R0, NEWLINE_
OUT

LD R1, SUB_RPN_ADDITION
JSRR R1

;ADD R6, R6, #-1


LD R0, NEWLINE_
OUT

LDR R0, R6, #0
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT







halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

STACK_BOT .FILL xA000   ;base
STACK_TOP .FILL xA002   ;max in stack (size 5, start at xA001)
STACK_TOS .FILL xA000   ;Top of stack, starts at base

STORE_TOS .BLKW #1
STORE_COUNT .BLKW #1

COUNTER .FILL #2
SPACE_ .FILL #32
NEWLINE_ .FILL x0A
TOP_BOT_MSG .STRINGZ "\nTop ----> Bottom\n"
NOW_POPPING .STRINGZ "\n\nNow popping.\n"
TOP_POPPED .STRINGZ "\n\nTop popped: "
TESTING_POP_ERROR .STRINGZ "\n\nTesting pop error.\n"
SUCCESS_MSG .STRINGZ "\nRan successfully.\n"


SUB_STACK_PUSH .FILL x3200  ;subroutine for stack push
SUB_STACK_POP .FILL x3400   ;subroutine for stack pop
SUB_RPN_ADDITION .FILL x3600  ;subroutine for rpn addition

.end

.orig xA001
STACK_SIZE .BLKW #2
;===============================================================================================
.end

; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3200
				 
				ST R0, BACKUP_R0_3200
				ST R1, BACKUP_R1_3200
            	ST R2, BACKUP_R2_3200
            	ST R3, BACKUP_R3_3200
            	ST R4, BACKUP_R4_3200
            	ST R5, BACKUP_R5_3200
            	;ST R6, BACKUP_R6_3200
            	ST R7, BACKUP_R7_3200
				
				ADD R2, R2, #-5
				BRz MAX_CAP
			    
			    STR R0, R6, #0
			    ;LDR R6, R6, #0
			    
			    BR END_MAX_CAP
			    
			    MAX_CAP
			        LEA R0, MAX_CAP_MSG
			        PUTS
			    END_MAX_CAP
			  
			  
			    
				LD R0, BACKUP_R0_3200
        		LD R1, BACKUP_R1_3200
        		LD R2, BACKUP_R2_3200
        		LD R3, BACKUP_R3_3200
        		LD R4, BACKUP_R4_3200
        		LD R5, BACKUP_R5_3200
        		;LD R6, BACKUP_R6_3200
        		LD R7, BACKUP_R7_3200
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data

BACKUP_R0_3200 .BLKW #1 ; Do this for R7 & each register that the subroutine changes
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
;BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1 ; ... EXCEPT for Return Value(s)

MAX_CAP_MSG .STRINGZ "\nOverflow error.\n"
;COUNTER_PUSH .FILL #5
;SPACE_PUSH .FILL #32
;NEWLINE_PUSH .FILL x0A
;TOP_BOT_MSG .STRINGZ "\nTop ----> Bottom\n"

;===============================================================================================
.end

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3400
				 
				ST R0, BACKUP_R0_3400
				ST R1, BACKUP_R1_3400
            	ST R2, BACKUP_R2_3400
            	ST R3, BACKUP_R3_3400
            	ST R4, BACKUP_R4_3400
            	ST R5, BACKUP_R5_3400
            	ST R6, BACKUP_R6_3400
            	ST R7, BACKUP_R7_3400
				
				
				NOT R4, R4
				ADD R4, R4, #1
				ADD R6, R6, R4
				BRz ERROR_POP
				
				LD R6, BACKUP_R6_3400
				
				LDR R0, R6, #0
				ADD R0, R0, #12
				ADD R0, R0, #12
				ADD R0, R0, #12
				ADD R0, R0, #12     ;convert to dec that we can see in console
				OUT
				AND R6, R6, #0
				ADD R6, R6, #-1
				
				;skip the error message, end subroutine
				BR END_ERROR_POP
				
				ERROR_POP
				    LEA R0, EMPTY_ERROR_MSG
				    PUTS
				END_ERROR_POP
				
			    
				LD R0, BACKUP_R0_3400
        		LD R1, BACKUP_R1_3400
        		LD R2, BACKUP_R2_3400
        		LD R3, BACKUP_R3_3400
        		LD R4, BACKUP_R4_3400
        		LD R5, BACKUP_R5_3400
        		;LD R6, BACKUP_R6_3400
        		LD R7, BACKUP_R7_3400	 
				 
				 
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data

BACKUP_R0_3400 .BLKW #1 ; Do this for R7 & each register that the subroutine changes
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1 ; ... EXCEPT for Return Value(s)

EMPTY_ERROR_MSG .STRINGZ "\n\nUnderflow error.\n"


;===============================================================================================
.end

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_ADD
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    added them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
.orig x3600
			ST R0, BACKUP_R0_3600
			ST R1, BACKUP_R1_3600
        	ST R2, BACKUP_R2_3600
        	ST R3, BACKUP_R3_3600
        	ST R4, BACKUP_R4_3600
        	ST R5, BACKUP_R5_3600
        	ST R6, BACKUP_R6_3600
        	ST R7, BACKUP_R7_3600	 
				 
			ST R6, FIRST_NUM
			ADD R6, R6, #-1
			ST R6, SEC_NUM
			ADD R6, R6, #-1
			LD R6, BACKUP_R6_3600
			LD R3, SUB_STACK_POP_S
			JSRR R3
			
			LD R6, BACKUP_R6_3600
			ADD R6, R6, #-1
			LD R0, NEWLINE
			OUT
			LD R2, COUNTER_
			ADD R2, R2, #-1
			JSRR R3
			
			LD R6, BACKUP_R6_3600
			add r6, r6, #-1
			
			AND R0, R0, #0
			AND R1, R1, #0
			LD R0, SEC_NUM
			LD R1, FIRST_NUM
			LDR R0, R0 #0
			LDR R1, R1, #0
			ADD R0, R0, R1
			;STR R6,R3, #0
			
			LD R1, SUB_STACK_PUSH_S
			JSRR R1
				 
			LD R0, BACKUP_R0_3600
    		LD R1, BACKUP_R1_3600
    		LD R2, BACKUP_R2_3600
    		LD R3, BACKUP_R3_3600
    		LD R4, BACKUP_R4_3600
    		LD R5, BACKUP_R5_3600
    		;LD R6, BACKUP_R6_3600
    		LD R7, BACKUP_R7_3600	 
			 
ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R0_3600 .BLKW #1 ; Do this for R7 & each register that the subroutine changes
BACKUP_R1_3600 .BLKW #1
BACKUP_R2_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R5_3600 .BLKW #1
BACKUP_R6_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1 ; ... EXCEPT for Return Value(s)

FIRST_NUM .BLKW #1
SEC_NUM .BLKW #1

SUB_STACK_PUSH_S .FILL x3200
SUB_STACK_POP_S .FILL x3400
NEWLINE .FILL x0A
COUNTER_ .FILL #2

;===============================================================================================
.end


; SUB_ADDED		

; SUB_GET_NUM		

; SUB_PRINT_DIGIT		Only needs to be able to print 1 digit numbers. 



