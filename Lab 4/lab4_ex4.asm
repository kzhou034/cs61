;=================================================

; 
;=================================================

.ORIG x3000

;---------------------
;Instructions
;---------------------

LD R1, ARRAY_PTR
LD R4, COUNTER
LD R0, VAL

DO_WHILE_LOOP
    STR R0, R1, #0    ;R1 <- R0 + #0
    ADD R0, R0, R0    ;adds r0 to itself and stores in r0
    ADD R1, R1, #1    ;increments array
    ADD R4, R4, #-1   ;decrements counter
    BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

;outputs number in the array 
LD R1, ARRAY_PTR
LD R4, COUNTER

OUTPUT
    LDR R0, R1, #0
    ADD R0, R0, #12     ;convert to chars that we normally read
    ADD R0, R0, #12
    ADD R0, R0, #12
    ADD R0, R0, #12
    OUT
    LD R0, newline
    OUT
    ADD R1, R1, #1
    ADD R4, R4, #-1
    BRp OUTPUT
END_OUTPUT

HALT

;------------------
;Local/remote data
;------------------

ARRAY_PTR .FILL x4000   ;pointer to beginning of array
COUNTER .FILL #10       ;used to make branch run 10 times
VAL .FILL #1           ;start at ascii decimal 1
newline .FILL x0A

.end
.orig x4000
ARRAY_SIZE .BLKW #10    ;reserves 10 spots in memory

.END
