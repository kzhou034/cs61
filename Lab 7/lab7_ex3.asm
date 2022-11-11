;=================================================

; 
;=================================================

; test harness
.orig x3000
    LD R6, STACK_ADDR
				 
	AND R0, R0, #0
	ADD R0, R0, #5
	
	LD R5, FACT_ADDR
	JSRR R5
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

FACT_ADDR .FILL x3100
STACK_ADDR .FILL xFE00




;===============================================================================================
.end

; subroutines:


.ORIG x3100



FACT ADD R6, R6, #-1
     STR R7, R6, #0
     ADD R6, R6, #-1
     STR R1, R6, #0
     ;ST R7, Save7_3100
     ;ST R4, Save4_3100 
     ADD R1, R0, #-1
     BRz DONE
     ADD R1, R0, #0
     ADD R0, R1, #-1
     JSR FACT
     LD R5, MUL_ADDR
     JSRR R5

DONE LDR R1, R6, #0
     ADD R6, R6, #1
     LDR R7, R6, #0
     ADD R6, R6, #1
     
     ;LD R4, Save4_3100
     ;LD R7, Save7_3100
     RET

MUL_ADDR .FILL x3200

;Save7_3100 .BLKW 1
;Save4_3100 .BLKW 1
.END

;when the FACT subroutine goes through it's second iteration, it rewrites the previous r7 return statement
;with something from within the subroutine itself. it can't return to main

;MULT subroutine rewrites r7 with an address two lines down from the previous return.

;r7 goes back and forth between x3107 and x3109 every iteration. 
;there is no address to return to main

.ORIG x3200


MUL ;ST R2, Save2_3200
    ;ST R7, BACKUP_R7_3200
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0

    ADD R2, R0, #0
    AND R0, R0, #0
    
LOOP ADD R0, R0, R1
     ADD R2, R2, #-1
     BRp LOOP
     
     LDR R2, R6, #0
     ADD R6, R6, #1
     LDR R7, R6, #0
     ADD R6, R6, #1
     ;LD R2, Save2_3200
     ;LD R7, BACKUP_R7_3200
     RET
     
;Save2_3200 .BLKW 1

;BACKUP_R7_3200 .BLKW 1

.END
