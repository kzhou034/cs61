;=================================================

; 
;=================================================

; test harness
.orig x3000
				 
	AND R0, R0, #0
	ADD R0, R0, #5
	
	LD R5, FACT_ADDR
	JSRR R5
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

FACT_ADDR .FILL x3100



;there are no backups for r7 so it never returns to he main function. 


;===============================================================================================
.end

; subroutines:


.ORIG x3100



FACT ST R1, Save1_3100
     ST R7, BACKUP_R7_3100 
     ADD R1, R0, #-1
     BRz DONE
     ADD R1, R0, #0
     ADD R0, R1, #-1
     JSR FACT
     LD R5, MUL_ADDR
     JSRR R5

DONE LD R2, Save1_3100
     LD R7, BACKUP_R7_3100
     RET

MUL_ADDR .FILL x3200

BACKUP_R7_3100 .BLKW 1

Save1_3100 .BLKW 1
.END

;when the FACT subroutine goes through it's second iteration, it rewrites the previous r7 return statement
;with something from within the subroutine itself. it can't return to main

;MULT subroutine rewrites r7 with an address two lines down from the previous return.

;r7 goes back and forth between x3107 and x3109 every iteration. 
;there is no address to return to main

.ORIG x3200


MUL ST R2, Save2_3200
    ST R7, BACKUP_R7_3200
    
    ADD R2, R0, #0
    AND R0, R0, #0
    
LOOP ADD R0, R0, R1
     ADD R2, R2, #-1
     BRp LOOP
     
     LD R2, Save2_3200
     LD R7, BACKUP_R7_3200
     RET
     
Save2_3200 .BLKW 1

BACKUP_R7_3200 .BLKW 1

.END
