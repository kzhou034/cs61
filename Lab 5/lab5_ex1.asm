;=================================================
; Name: Kelley Zhou
; Email: kzhou034@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 23
; TA: Shirin
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
    LD R6, SUB_ROUT
	JSRR R6
    ;LD R0, newline_
    ;OUT
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
VAL .FILL #1            ;start at ascii decimal 1
newline_     .FILL x0A

SUB_ROUT .FILL x3200

.end
.orig x4000
ARRAY_SIZE .BLKW #10    ;reserves 10 spots in memory

.END

;------------------
;ASSIGNMENT 3
;------------------


;=======================================================================
; Subroutine: SUB_PRINT_BINARY_3200
; Parameter: (Register you are “passing”): the value that will be converted to a 16-bit binary
; Postcondition: subroutine has converted the hexadecimal to a 16-bit binary and printed it to the console
; Return Value: 16-bit binary representation of a hexadecimal value
;=======================================================================
.orig x3200 ; use the starting address as part of the sub name
;========================
; Subroutine Instructions
;========================
; (1) Backup R7 and any registers that this subroutine changes, except for Return Values

                    ST R0, BACKUP_R0_3200       ;R0 is modified by the subroutine
            		ST R1, BACKUP_R1_3200
            		ST R2, BACKUP_R2_3200
            		ST R3, BACKUP_R3_3200
            		ST R4, BACKUP_R4_3200
            		ST R5, BACKUP_R5_3200
            		ST R6, BACKUP_R6_3200
            		ST R7, BACKUP_R7_3200

; (2) Whatever algorithm this subroutine is intended to perform - only ONE task per sub!!
                
                ;LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
                ADD R1, R0, #0			; R1 <-- value to be displayed as binary 
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

; (3) Restore the registers that you backed up

                    LD R0, BACKUP_R0_3200
            		LD R1, BACKUP_R1_3200
            		LD R2, BACKUP_R2_3200
            		LD R3, BACKUP_R3_3200
            		LD R4, BACKUP_R4_3200
            		LD R5, BACKUP_R5_3200
            		LD R6, BACKUP_R6_3200
            		LD R7, BACKUP_R7_3200

; (4) RET - return to the instruction following the subroutine invocation

                    ret

;========================
; Subroutine Data
;========================
BACKUP_R0_3200 .BLKW #1 ; Do this for R7 & each register that the subroutine changes
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1 ; ... EXCEPT for Return Value(s)

Value_ptr	.FILL x3200	; The address where value to be displayed is stored
num_bits    .FILL #16   ;number of bits to print out

newline     .FILL x0A
space       .FILL #32   ;ascii dec code for space
conversion  .FILL #48  ;used after 8 binary bits are printed. 

;========================
; END SUBROUTINE
;========================

                    .end

