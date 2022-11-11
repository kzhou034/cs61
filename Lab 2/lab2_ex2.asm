;=================================================

;=================================================


.ORIG x3000
    ; ----------
    ; Instructions
    ; ----------
    
    LDI R3, DEC_65_PTR    ;R3 <- #65
    LDI R4, HEX_41_PTR    ;R4 <- x41
    
    ;increment R3 and R4 by 1
    ADD R3, R3, #1
    ADD R4, R4, #1
    
    ;store incremented values back into addresses x4000 and x4001
    STI R3, DEC_65_PTR
    STI R4, HEX_41_PTR
    
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
