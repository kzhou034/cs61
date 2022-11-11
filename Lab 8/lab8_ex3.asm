;=================================================
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

;ex 2 harness
LD R6, SUB_IS_PALINDROME
JSRR R6

LEA R0, PAL_MSG
PUTS
LEA R0, ARRAY_SIZE
PUTS

ADD R4, R4, #-1      ;BRINGS UP R4, CHECKS FOR IF 1
BRz PAL_TRUE

PAL_FALSE
    LEA R0, PAL_MSG_FALSE
    PUTS
    BR END_PAL_TRUE
PAL_TRUE
    LEA R0, PAL_MSG_TRUE
    PUTS
END_PAL_TRUE

HALT

;data
CHAR_COUNT .FILL #0     ;counts num of characters in array

;ARRAY_ADDR .FILL x4000
SUB_GET_STRING .FILL x3200
SUB_IS_PALINDROME .FILL x3400

PAL_MSG .STRINGZ "\nThe string \""
PAL_MSG_TRUE .STRINGZ "\" IS a palindrome"
PAL_MSG_FALSE .STRINGZ "\" IS NOT a palindrome"

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
            
            ;LD R1, ARR_ADDR
            
            GET_LOOP
                GETC
                OUT
                
                ADD R0, R0, #-10    ;check for sentinel enter
                BRz END_GET_LOOP
                ADD R0, R0, #10     ;undo the check
                
                ADD R0, R0, #-15
                ADD R0, R0, #-15
                ADD R0, R0, #-2     ;check for space
                BRz GET_LOOP        ;don't store space
                ADD R0, R0, #15
                ADD R0, R0, #15
                ADD R0, R0, #2      ;undo check
                
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
            ARR_ADDR .FILL x4000
            
.END




.ORIG x3400
;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
; a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------------------------------------

ST R1, BACKUP_R1_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

LD R6, TOUPPER
JSRR R6

COMP_LOOP
    ADD R2, R1, R5      ;add the # of chars in array (get from r5)
    ADD R2, R2, #-1     ;holds addr of the last element in array
    
    ;r1 holds addr of beginning of array
    ST R2, END_CHECK
    ST R1, START_CHECK
    
    NOT R2, R2
    ADD R2, R2, #1
    ADD R0, R2, R1
    BRzp IS_PAL      ;IF ONE CHAR LEFT, IS AUTOMATICALLY PALINDROME
                    ;IF R2 IS LESS THAN R0 AFTER THIS, IS PAL
    
    LD R1, START_CHECK
    LD R2, END_CHECK
    
    LDR R3, R1, #0
    LDR R0, R2, #0
    NOT R0, R0
    ADD R0, R0, #1
    ADD R3, R3, R0
    BRz NEXT_COMP
END_COMP_LOOP

BR END_NEXT_COMP

NEXT_COMP
    ADD R5, R5, #-2
    ADD R1, R1, #1  ;INCREMENT ARRAY ADDR, R2 INCREMENTED WHEN GETS BACK TO LOOP
    BR COMP_LOOP
END_NEXT_COMP

BR END_IS_PAL

IS_PAL          ;is palindrome IF ONE CHAR
ADD R4, R4, #1  ;UPDATES FLAG IF IT IS PALINDROME
END_IS_PAL

LD R5, BACKUP_R5_3400
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET

;data
BACKUP_R1_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1
START_CHECK .FILL x0
END_CHECK .FILL x0
TOUPPER .FILL x3600


.END





.ORIG x3600
;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case in-place
; i.e. the upper-case string has replaced the original string
; No return value, no output (but R1 still contains the array address, unchanged).
;------------------------------------------------------------------------------------------------------------------

ST R0, BACKUP_R0_3600
ST R1, BACKUP_R1_3600
ST R3, BACKUP_R3_3600
ST R7, BACKUP_R7_3600

LD R3, CONVERSION

LOOP
    LDR R0, R1, #0
    BRz END_LOOP
    
    AND R0, R0, R3      ;AND what's in r0 with what's in r3
	STR R0, R1, #0      ;store in array
    
    ADD R1, R1, #1      ;increment array
    
    BR LOOP
END_LOOP

LD R0, BACKUP_R0_3600
LD R1, BACKUP_R1_3600
LD R3, BACKUP_R3_3600
LD R7, BACKUP_R7_3600

RET

BACKUP_R0_3600 .BLKW #1
BACKUP_R1_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1

CONVERSION .FILL x5F

.END
