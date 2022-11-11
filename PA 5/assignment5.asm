; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Kelley Zhou
; Email: kzhou034@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 23
; TA: Shirin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
ld r6, stack_addr

; call main subroutine
lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
; * put your code here

LEA R0, user_prompt
PUTS

LEA R1, user_string

LD R5, get_user_string_addr
JSRR R5

; find size of input string
; * put your code here
LD R5, strlen_addr
JSRR R5

; call palindrome method
; * put your code here
AND R2, R2, #0
ADD R2, R1, R0      ;PUT INTO R2, R1 + # OF CHARACTERS GIVEN BY R0
ADD R2, R2, #-1     ;-1 because includes first addr

;PASS BOTH R1 AND R2 INTO THE PALINDROME SUBROUTINE
LD R5, palindrome_addr
JSRR R5

; determine of stirng is a palindrome
; * put your code here

ADD R0, R0, #0
BRz PAL_FALSE

; print the result to the screen
; * put your code here
LEA R0, result_string
PUTS
BR END_PAL_FALSE

; decide whether or not to print "not"
; * put your code here
PAL_FALSE
    LEA R0, result_string
    PUTS
    LEA R0, not_string
    PUTS
END_PAL_FALSE

LEA R0, final_string
PUTS

HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ "Enter a string: "
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ	"a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  100

.END

;---------------------------------------------------------------------------------
; get_user_string - DO NOT FORGET TO REPLACE THIS HEADER WITH THE PROPER HEADER

; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
; terminated by the [ENTER] key (the "sentinel"), and has stored
; the received characters in an array of characters starting at (R1).
; the array is NULL-terminated; the sentinel character is NOT stored.
; R1 contains the starting address of the array unchanged.
;---------------------------------------------------------------------------------
.ORIG x3200
get_user_string
; Backup all used registers, R7 first, using proper stack discipline
    ST R0, BACKUP_R0_3200
    ST R1, BACKUP_R1_3200
    ;ST R5, BACKUP_R5_3200
    ST R7, BACKUP_R7_3200
    
    ;LD R3, NUM_CHAR
    
    GET_LOOP
        GETC
        OUT
        
        ADD R0, R0, #-10    ;check for sentinel enter
        BRz END_GET_LOOP
        ADD R0, R0, #10     ;undo the check
        
        ;ADD R0, R0, #-15    ;check for space
        ;ADD R0, R0, #-15
        ;ADD R0, R0, #-2
        BRz GET_LOOP
        ;ADD R0, R0, #15
        ;ADD R0, R0, #15
        ;ADD R0, R0, #2      ;undo the check
        
        ;ADD R3, R3, #1      ;increment char_count
        
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
    
    LD R0, BACKUP_R0_3200
    LD R1, BACKUP_R1_3200
    ;LD R5, BACKUP_R5_3200
    LD R7, BACKUP_R7_3200
    
    RET
    
    ;NUM_CHAR .FILL #0
    
    ;TOUPPER .FILL x3600
    BACKUP_R0_3200 .BLKW #1
    BACKUP_R1_3200 .BLKW #1
    ;BACKUP_R5_3200 .BLKW #1
    BACKUP_R7_3200 .BLKW #1
; Resture all used registers, R7 last, using proper stack discipline
.END

;---------------------------------------------------------------------------------
; strlen - DO NOT FORGET TO REPLACE THIS HEADER WITH THE PROPER HEADER
;
; Subroutine: strlen
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine saves the number of characters in the string into R0.
; Return Value: R0 (contains the number of characters in the string)
; R1 still contains the array address, unchanged.
;---------------------------------------------------------------------------------
.ORIG x3300
strlen
; Backup all used registers, R7 first, using proper stack discipline
    ST R1, BACKUP_R1_3300
    ;ST R0, BACKUP_R0_3300
    ST R7, BACKUP_R7_3300
    
    AND R0, R0, #0
    
    STRLOOP
        LDR R2, R1, #0
        BRz END_STRLOOP
        ADD R0, R0, #1
        ADD R1, R1, #1
        BR STRLOOP
    END_STRLOOP
    
    LD R1, BACKUP_R1_3300
    ;LD R0, BACKUP_R0_3300
    LD R7, BACKUP_R7_3300
    
    RET
; Resture all used registers, R7 last, using proper stack discipline

BACKUP_R1_3300 .BLKW #1
;BACKUP_R0_3300 .BLKW #1
BACKUP_R7_3300 .BLKW #1
.END

;---------------------------------------------------------------------------------
; palindrome - DO NOT FORGET TO REPLACE THIS HEADER WITH THE PROPER HEADER
;
; Subroutine: palindrome
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R2): The ending address of a null-terminated string
; Postcondition: The subroutine has determined whether the string at (R1) is
; a palindrome or not, and returned a flag to that effect.
; Return Value: R0 {1 if the string is a palindrome, 0 otherwise}
;---------------------------------------------------------------------------------
.ORIG x3400

;ST R5, BACKUP_R5_3400
ADD R6, R6, #-1
STR R7, R6, #0      ;return val
ADD R6, R6, #-1
STR R5, R6, #0
LD R5, TOUPPER
JSRR R5
LDR R5, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0      ;return val
ADD R6, R6, #1
;LD R5, BACKUP_R5_3400


palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline
ADD R6, R6, #-1
STR R7, R6, #0      ;return val
ADD R6, R6, #-1
STR R4, R6, #0
ADD R6, R6, #-1
STR R3, R6, #0
    
AND R4, R4, #0      ;CLEAR UP R4
ADD R4, R4, R2      ;ADD R4 AND R2 TOGETHER, STORE IN R4
;ADD R4, R4, #-1     ;R2 HAS PTR TO LAST CHAR IN ARRAY

NOT R4, R4
ADD R4, R4, #1      ;TWO'S COMPLEMENT --> NEGATIVE

ADD R4, R1, R4      ;ADD R1(PTR TO FIRST CHAR IN ARR) WITH R4 (NEG PTR TO LAST CHAR), STORE IN R4
BRzp FLAG_ONE

LDR R3, R1, #0      ;LOAD VAL OF R1 INTO R3
LDR R4, R2, #0      ;LOAD VAL OF R2 INTO R4

NOT R4, R4
ADD R4, R4, #1      ;TWO'S COMPLEMENT --> NEGATIVE

ADD R3, R3, R4
BRnp END_FLAG_ONE           ;NOT SAME ASCII CODE --> NOT PALINDROME

ADD R1, R1, #1      ;INCREMENT PTR TO 1ST CHAR
ADD R2, R2, #-1     ;DECREMENT PTR TO 2ND CHAR

JSR palindrome      ;GOES BACK TO BEGINNING OF FUNCTION --> RECURSE

BR END_FLAG_ZERO

FLAG_ONE
    AND R0, R0, #0
    ADD R0, R0, #1
    BR DONE
END_FLAG_ONE

AND R0, R0, #0
END_FLAG_ZERO

DONE

LDR R3, R6, #0
ADD R6, R6, #1
LDR R4, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0      ;return val
ADD R6, R6, #1

RET
; Resture all used registers, R7 last, using proper stack discipline

TOUPPER .FILL x3600
;BACKUP_R5_3400 .BLKW #1

.END




;taken from my lab8_ex3

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
    
    AND R0, R0, R3
	STR R0, R1, #0
    
    ADD R1, R1, #1
    
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