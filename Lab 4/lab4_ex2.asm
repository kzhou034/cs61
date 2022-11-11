;=================================================

; 
;=================================================
.ORIG x3000

;---------------------
;Instructions
;---------------------

LD R1, ARRAY_PTR
LD R4, COUNTER
LD R3, VAL

DO_WHILE_LOOP
    STR R3, R1, #0
    ADD R1, R1, #1
    ADD R3, R3, #1
    ADD R4, R4, #-1
    BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

LD R1, ARRAY_PTR
ADD R1, R1, #6
LDR R2, R1, #0


LD R1, ARRAY_PTR
LD R4, COUNTER

OUTPUT
    LDR R0, R1, #0
    ADD R0, R0, #12
    ADD R0, R0, #12
    ADD R0, R0, #12
    ADD R0, R0, #12
    OUT
    ADD R1, R1, #1
    ADD R4, R4, #-1
    BRp OUTPUT
END_OUTPUT

HALT

;---------------------
;Local/remote data
;------------------

ARRAY_PTR .FILL x4000   ;pointer to beginning of array
ARRAY_SIZE .BLKW #10    ;reserves 10 spots in memory
COUNTER .FILL #10       ;used to make branch run 10 times
VAL .FILL #0           ;start at ascii decimal 0

.END
