;=================================================

; 
;=================================================

.ORIG x3000
    ; ----------
    ; Instructions
    ; ----------
    
    LD R5, DEC_65_PTR ;r5 holds address of dec65ptr
    LD R6, HEX_41_PTR  ;r6 holds address of hex41ptr
    
    LDR R3, R5, #0 ;go to address that r5 is holding and take value 
    LDR R4, R6, #0 ;go to address that r6 is holding and take value
    
    ;increment R3 and R4 by 1
    ADD R3, R3, #1
    ADD R4, R4, #1
    
    ;store incremented values back into addresses x4000 and x4001
    STR R3, R5, #0 ;line 16
    STR R4, R6, #0 ;line 17
    
    HALT
    
    ;-----------
    ; local data
    ;-----------
    
    DEC_65_PTR .FILL x4000 ;stores #65 into memory here
    HEX_41_PTR .FILL x4001 ;stores x41 into memory here

    .END

    ;; Remote data   (copied from lab pdf)
    .orig x4000
    NEW_DEC_65 .FILL #65
    NEW_HEX_41 .FILL x41
   ; .end

.END
