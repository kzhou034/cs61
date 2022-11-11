;=================================================
; Name: Kelley Zhou
; Email:  kzhou034@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 23
; TA: Shirin
; 
;=================================================

.ORIG x3000

; ----------
; Instructions
; ----------

LD R0, HEX_61     ;load value of HEX_61 into r0
LD R1, HEX_1A     ;load value of HEX1A into r1

DO_WHILE_LOOP
    OUT
    ADD R0, R0, #1     ;increment r0 by 1
    ADD R1, R1, #-1    ;decrement r1 by 1
    BRp DO_WHILE_LOOP  ;if previous line (line 23) is positive, go back to DO_WHILE_LOOP (line 20)
END_DO_WHILE_LOOP

HALT       
;-----------
; local data
;-----------

HEX_61 .FILL x61   ;hard-code local data value x61
HEX_1A .FILL x1A   ;hard-code local data value x1A

.END