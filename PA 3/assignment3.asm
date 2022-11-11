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
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD R2, num_bits                 ;bit counter (16)            
LD R5, conversion

bits_loop                       ;for (i=15 downto 0):
    AND R0, R0, #0
    ADD R1, R1, #0              ;(bringing up r1 in loop)
    BRn PRINT_ONE               ;if msb is a 1, go to print one
    ADD R1, R1, #0
    BRzp PRINT_ZERO              ;else, print 0
    
        PRINT_ONE
            ADD R0, R0, #1
            ADD R0, R0, R5      ;convert to char that user can read in the console
            OUT
            BR END_PRINT_ZERO
        END_PRINT_ONE
        
        PRINT_ZERO
            ADD R0, R0, #0
            ADD R0, R0, R5
            OUT
        END_PRINT_ZERO
    
    ADD R1, R1, R1              ;left shit is multiplying by 2
    ADD R2, R2, #-1
    BRz end_bits_loop
    
    ADD R4, R2, #0              ;copy curr bit counter into r4
    ADD R4, R4, #-12            ;subtract 12, checking if 4 bits have been printed already
    BRz OUT_SPACE
    
    ADD R4, R2, #0              ;copy curr bit counter into r4
    ADD R4, R4, #-8             ;subtract 8, checking if 8 bits have been printed already
    BRz OUT_SPACE
    
    ADD R4, R2, #0              ;copy curr bit counter into r4
    ADD R4, R4, #-4             ;subtract 4, checking if 12 bits have been printed already
    BRz OUT_SPACE
    
    ADD R4, R2, #0              ;copy curr bit counter into r4
    BRz end_pls                 ;if no more bits, go to end of loop to output newline
    
    BRp bits_loop
    
end_bits_loop

OUT_SPACE
    ADD R4, R2, #0
    BRz end_pls
    LD R0, space
    OUT
    ADD R4, R2, #0
    BRz end_pls
    BR bits_loop
END_OUT_SPACE

end_pls
LD R0, newline
OUT

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
num_bits    .FILL #16   ;number of bits to print out

newline     .FILL x0A
space       .FILL #32   ;ascii dec code for space
conversion  .FILL #48  ;used after 8 binary bits are printed. 



.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
