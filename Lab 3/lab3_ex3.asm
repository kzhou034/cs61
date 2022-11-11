;=================================================

;=================================================

.ORIG x3000

;--------------------
;Instructions
;--------------------

LD R1, ARRAY_PTR
LD R2, LOOP
LD R3, LOOP2

DO_WHILE_LOOP
    GETC                ;gets input from user
    OUT
    STR R0, R1, #0      ;stores user input into array
    ADD R1, R1, #1      ;increments address by 1 so it goes to the next space in memory
    ADD R2, R2, #-1     ;decrements loop counter
    BRp DO_WHILE_LOOP   ;if number is positive (not negative and not zero) go back to beginning of DO_WHILE_LOOP
END_DO_WHILE_LOOP

LD R0, newline
OUT

LD R1, ARRAY_PTR

OUTPUT_ARRAY
    LDR R0, R1, #0
    OUT
    LD R0, newline
    OUT
    ADD R1, R1, #1
    ADD R3, R3, #-1
    BRp OUTPUT_ARRAY
END_OUTPUT_ARRAY
    

HALT

;--------------------
;local data
;--------------------
ARRAY_PTR .FILL x3100   ;array starts here
ARRAY_1 .BLKW #10       ;set up a blank array of 10 locations
LOOP .FILL #10          ;loop counter
LOOP2 .FILL #10
newline .FILL x0A	; newline character - use with LD followed by OUT

.END
