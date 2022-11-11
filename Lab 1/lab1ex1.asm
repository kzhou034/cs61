
; 
;=================================================

.ORIG x3000
; ----------
; Instructions
; ----------
;LD R1, DEC_0    ;R1 <- #0                  REPLACED LINE WITH BELOW LINE
AND R1, R1, x0   ;R1 <- (R1) AND x0000      REPLACED ABOVE LINE WITH THIS LINE
LD R2, DEC_12    ;R2 <- #12
LD R3, DEC_6     ;R3 <- #6

DO_WHILE_LOOP
    ADD R1, R1, R2     ;R1 <- R1 + R2
    ADD R3, R3, #-1    ;R3 <- R3 - #1
    BRp DO_WHILE_LOOP  ;if (R4 > 0), go to DO_WHILE_LOOP
END_DO_WHILE_LOOP

HALT       ;halt program (like exit() in c++)
;-----------
; local data
;-----------
DEC_0 .FILL #0   ;put #0 into memory here
DEC_12 .FILL #12 ;put #12 into memory here
DEC_6 .FILL #6   ;put #6 into memory here

.END
