;=================================================
; Name: Kelley Zhou
; Email: kzhou034@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 23
; TA: Shirin
; 
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
    ADD R2, R2, #-1     ;decrements loop counter. 
    ADD R0, R0, #-10     ;hex for newline is A (Dec: #10)
    BRnp DO_WHILE_LOOP   ;if r2 is not 0, continue looping
END_DO_WHILE_LOOP

;enter key (newline) has been pressed

LD R0, newline
OUT

LD R1, ARRAY_PTR

OUTPUT_ARRAY
    LDR R0, R1, #0
    OUT
    ;LD R0, newline
    ;OUT
    ADD R4, R0, #0 ;moving r0's character into r4 
    ADD R1, R1, #1
    ADD R3, R3, #-1
    ADD R4, R4, #-10    ;checking if the char in r4 is a newline ()
    BRnp OUTPUT_ARRAY
END_OUTPUT_ARRAY

LD R0, newline
OUT

HALT

;--------------------
;local data
;--------------------
ARRAY_PTR .FILL x4000   ;array starts here
ARRAY_1 .BLKW #100       ;set up a blank array of 10 locations
LOOP .FILL #100          ;loop counter (get at most 100 characters)
LOOP2 .FILL #100
newline .FILL x0A	; newline character - use with LD followed by OUT

.END