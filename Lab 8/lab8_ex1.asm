;=================================================
; Name: Kelley Zhou
; Email: kzhou034@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 23
; TA: Shirin
; 
;=================================================

.ORIG x3000
;test harness

LEA R1, ARRAY_SIZE
LD R5, CHAR_COUNT
LD R6, SUB_GET_STRING
JSRR R6

LEA R0, ARRAY_SIZE
PUTS

HALT

;data
CHAR_COUNT .FILL #0     ;counts num of characters in array

;ARRAY_ADDR .FILL x4000
SUB_GET_STRING .FILL x3200
ARRAY_SIZE .BLKW #100

.END



.ORIG x3200
;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
; terminated by the [ENTER] key (the "sentinel"), and has stored
; the received characters in an array of characters starting at (R1).
; the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel characters read from the user.
; R1 contains the starting address of the array unchanged.
;-----------------------------------------------------------------------------------------------------------------
            
            ST R1, BACKUP_R1_3200
            ST R7, BACKUP_R7_3200
            
            GET_LOOP
                GETC
                OUT
                
                ADD R0, R0, #-10    ;check for sentinel enter
                BRz END_GET_LOOP
                ADD R0, R0, #10     ;undo the check
                
                ADD R5, R5, #1      ;increment char_count
                
                ;if it isn't an enter, store into array
                STR R0, R1, #0
                ADD R1, R1, #1      ;increment the spot in the array
                
                BR GET_LOOP
            END_GET_LOOP
            
            ;the string of text will be stored starting at x4000 
            ;and will be NULL TERMINATED (AND R0, R0, #0)
            ;(i.e. the subroutine will store zero (x0000 = #0 ='\0') at the end of the array)
            AND R0, R0, #0
            STR R0, R1, #0
            
            LD R1, BACKUP_R1_3200
            LD R7, BACKUP_R7_3200
            
            RET
            
            BACKUP_R1_3200 .BLKW #1
            BACKUP_R7_3200 .BLKW #1
            
.END