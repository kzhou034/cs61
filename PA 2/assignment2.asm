;=========================================================================

; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

GETC
OUT
ADD R1, R0, #0   ;store what was just inputted here
LD R0, newline   ;newline
OUT              ;out the newline

GETC
OUT
ADD R2, R0, #0   ;store what was just inputted here
LD R0, newline   ;newline
OUT              ;out the newline

ADD R0, R1, #0
OUT              ;output the first number that was inputted
LEA R0, minus    ;go to the address of label minus
PUTS             ;output what was stored in that address

ADD R0, R2, #0   
OUT              ;output second number that was inputted
LEA R0, equal    ;go to address of label equal
PUTS             ;output what was stored in that address

ADD R1, R1, #12
ADD R1, R1, #12
ADD R1, R1, #12
ADD R1, R1, #12

ADD R2, R2, #12
ADD R2, R2, #12
ADD R2, R2, #12
ADD R2, R2, #12


NOT R2, R2
ADD R2, R2, #1   ;this + previous line -> 2's complement of r2
;AND R3, R3, x0
ADD R3, R1, R2   ; R3 <- R1 - R2
BRzp zp_print

AND R0, R0, x0
LEA R0, negative
PUTS
NOT R3, R3
ADD R3, R3, #1
;AND R0, R0, x0
;ADD R0, R3, #0
;ADD R0, R0, #12
;ADD R0, R0, #12
;ADD R0, R0, #12
;ADD R0, R0, #12
;OUT

zp_print
    AND R0, R0, x0
    ADD R0, R3, #0
    ADD R0, R0, #12
    ADD R0, R0, #12
    ADD R0, R0, #12
    ADD R0, R0, #12
    OUT
end_zp_print

LD R0, newline
OUT

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL x0A	; newline character - use with LD followed by OUT

minus .STRINGZ " - "
negative .STRINGZ "-"
equal .STRINGZ " = "

;---------------	
; END of PROGRAM
;---------------	
.END

