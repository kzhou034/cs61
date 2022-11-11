;=================================================
; 
;=================================================

.ORIG x3000
    ; ----------
    ; Instructions
    ; ----------
    
    LD R5, DATA_PTR
    
    LDR R3, R5, #0 ;go to address that r5 is holding and take value 
    LDR R4, R5, #1 ;go to address that r5 +1 is holding and take value
    
    ;increment R3 and R4 by 1
    ADD R3, R3, #1
    ADD R4, R4, #1
    
    ;store incremented values back into addresses x4000 and x4001
    STR R3, R5, #0 ;line 16
    STR R4, R5, #1
    
    HALT
    
    ;-----------
    ; local data
    ;-----------
    
    DATA_PTR .FILL x4000  ;pointer to address x4000, which holds val #65

    .END

    ;; Remote data   (copied from lab pdf)
    .orig x4000
    NEW_DEC_65 .FILL #65
    NEW_HEX_41 .FILL x41
   ; .end

.END
