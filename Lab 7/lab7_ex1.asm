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
     ;ST R7, BACKUP_R7_3100 

    ADD R1, R0, #-1
    BRz DONE
    ADD R1, R0, #0
    ADD R0, R1, #-1
    JSR FACT
    LD R5, MUL_ADDR
    JSRR R5

DONE LD R2, Save1_3100
     ;LD R7, BACKUP_R7_3100
     RET

MUL_ADDR .FILL x3200

;BACKUP_R7_3100 .BLKW 1

Save1_3100 .BLKW 1
.END




.ORIG x3200


MUL ST R2, Save2_3200
    ;ST R7, BACKUP_R7_3200
    
    ADD R2, R0, #0
    AND R0, R0, #0
    
LOOP ADD R0, R0, R1
     ADD R2, R2, #-1
     BRp LOOP
     
     LD R2, Save2_3200
     ;LD R7, BACKUP_R7_3200
     RET
     
Save2_3200 .BLKW 1

;BACKUP_R7_3200 .BLKW 1

.END
