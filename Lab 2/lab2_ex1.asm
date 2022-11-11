;=================================================

; 
;=================================================

.ORIG x3000
; ----------
; Instructions
; ----------

LD R3, DEC_65    ;R3 <- #65
LD R4, HEX_41    ;R4 <- x41

HALT

;-----------
; local data
;-----------

DEC_65 .FILL #65 ;stores #65 into memory here
HEX_41 .FILL x41 ;stores x41 into memory here

.END
