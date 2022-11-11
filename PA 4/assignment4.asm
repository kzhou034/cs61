;=========================================================================

; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

; output intro prompt
					BR INTRO_PROMPT
					
					ERROR_PROMPT
					    LD R1, five_digits
					    
					    LD R0, newline
					    OUT
					    
					    LD R0, errorMessagePtr
					    PUTS
					END_ERROR_PROMPT
					
					INTRO_PROMPT
						AND R4, R4, #0          ;discard/clear up R4
						AND R3, R3, #0
						LD R1, five_digits
						LD R0, introPromptPtr
						PUTS
					END_INTRO_PROMPT
						
; Set up flags, counters, accumulators as needed
                        
                        
; Get first character, test for '\n', '+', '-', digit/non-digit 	
			        	    GETC
			        	    OUT
			            
; is very first character = '\n'? if so, just quit (no message)!
                            ADD R0, R0, #-10
                            BRz ENTER_PRESSED
                        
; is it = '+'? if so, ignore it, go get digits
                        PLUS_CHECK
                            ADD R0, R0, #10     ;undo the newline test
					        
                            ADD R0, R0, #-13
                            ADD R0, R0, #-15
                            ADD R0, R0, #-15    ;#43 is ascii for '+'
                            BRz PLUS_PRESSED
                                
                            BR MINUS_CHECK      ;if not plus, go check if minus
                        
                            PLUS_PRESSED
                                LD R2, flag ;should be 0 (positive)
                                BR GET_DIGITS
                            END_PLUS_PRESSED
                        
                        END_PLUS_CHECK
; is it = '-'? if so, set neg flag, go get digits
					    MINUS_CHECK
					        ADD R0, R0, #13
					        ADD R0, R0, #15
					        ADD R0, R0, #15     ;undo the plus test

					        ADD R0, R0, #-15
					        ADD R0, R0, #-15
					        ADD R0, R0, #-15    ;#45 is the ascii for '-'
					        BRz MINUS_PRESSED
					        
					        BR ZERO_CHECK       ;if not minus, go check if <= 0
					    
				    		MINUS_PRESSED
				                LD R2, flag
				                ADD R2, R2, #-1 ;now it's negative because of the -1
				                BR GET_DIGITS
				            END_MINUS_PRESSED
					    END_MINUS_CHECK
; is it < '0'? if so, it is not a digit	- o/p error message, start over
                        ZERO_CHECK
                            ADD R0, R0, #15
                            ADD R0, R0, #15
                            ADD R0, R0, #15     ;undo the minus test
					        
                            ADD R0, R0, #-3
                            ADD R0, R0, #-15
                            ADD R0, R0, #-15
                            ADD R0, R0, #-15    ;#48 is the ascii for '0'. it should not conflict with the previous tests because they were already tested
                            BRn ERROR_PROMPT
                            
                        END_ZERO_CHECK
; is it > '9'? if so, it is not a digit	- o/p error message, start over
				        NINE_CHECK
				            ADD R0, R0, #3
				            ADD R0, R0, #15
                            ADD R0, R0, #15
                            ADD R0, R0, #15     ;undo the 0 test
					        
				            ADD R0, R0, #-12
				            ADD R0, R0, #-15
				            ADD R0, R0, #-15
				            ADD R0, R0, #-15    ;#57 is the ascii for '9' and shouldn't conflict with the previous tests
				            BRp ERROR_PROMPT
				        
				            ADD R1, R1, #-1     ;if you made it here, then you're a digit. -1 to the digit counter
				            
				            ADD R3, R3, #1      ;notifies program that the FIRST DIGIT was a numerical char --> positive
				            
				            ADD R2, R2, #0      ;the number is positive
				            BR YOU_POSITIVE
				        END_NINE_CHECK
; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					   GET_DIGITS
					        GETC
					        OUT
					        
					        ADD R0, R0, #-10
                            BRz ENTER_PRESSED
                            ADD R0, R0, #10         ;undo the enter test
					        
					        GETTER_ZERO_CHECK
                                ADD R0, R0, #-3
                                ADD R0, R0, #-15
                                ADD R0, R0, #-15
                                ADD R0, R0, #-15    ;#48 is the ascii for '0'. it should not conflict with the previous tests because they were already tested
                                BRn ERROR_PROMPT
                            
                            END_GETTER_ZERO_CHECK
                            
                            GETTER_NINE_CHECK
    				            
    				            
    				            ADD R0, R0, #3
    				            ADD R0, R0, #15
                                ADD R0, R0, #15
                                ADD R0, R0, #15     ;undo the getter 0 test
                                
    				            ADD R0, R0, #-12
    				            ADD R0, R0, #-15
    				            ADD R0, R0, #-15
    				            ADD R0, R0, #-15    ;#57 is the ascii for '9' and shouldn't conflict with the previous tests
    				            BRp ERROR_PROMPT
    				        
    				            ;congrats, no errors. you can store it
    				            ADD R0, R0, #12
    				            ADD R0, R0, #15
    				            ADD R0, R0, #15
    				            ADD R0, R0, #15     ;undo the getter 9 check
    				            
    				            ADD R0, R0, #-3
                                ADD R0, R0, #-15
                                ADD R0, R0, #-15
                                ADD R0, R0, #-15    ;convert to ascii to store into r4
    				            
    				            BR STORE_IT
    				        
    				            COME_BACK_PLS
    				        
    				            ADD R1, R1, #-1     ;decrement the counter
    				            
    				            YOU_POSITIVE_2
    				            
    				            ADD R1, R1, #0
    				            
    				            BRp GET_DIGITS
    				            
    				        END_GETTER_NINE_CHECK
    				        
    				        BR END_PLS
					   END_GET_DIGITS
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
                        STORE_IT
                            MULTIPLY_10
                                ADD R4, R4, R4      ;mult by 2
                                ADD R5, R4, R4      ;mult by 4
                                ADD R5, R5, R5      ;mult by 8 
                                ADD R4, R4, R5      ;mult by 10
                            END_MULTIPLY_10
				            
				            ADD R4, R4, R0
				            
				            ADD R3, R3, #0
				            BRp YOU_POSITIVE
				            
				            BR COME_BACK_PLS
				            
                        END_STORE_IT
                        
                        YOU_POSITIVE
                            ADD R0, R0, #12
				            ADD R0, R0, #15
				            ADD R0, R0, #15
				            ADD R0, R0, #15
				            ADD R0, R0, #-3
                            ADD R0, R0, #-15
                            ADD R0, R0, #-15
                            ADD R0, R0, #-15 ;convert to ascii
                            
                            ADD R4, R4, R0
                            
			                ADD R3, R3, #-1
			                BR YOU_POSITIVE_2           ;THIS SHOULD ONLY RUN LIKE ONCE
			            END_YOU_POSITIVE
                        
; remember to end with a newline!
                        END_PLS
				        LD R0, newline
				        OUT
                        ENTER_PRESSED
                        
                        ADD R2, R2, #0
                        BRn CHANGE_TO_NEG
                        
                        BR END_CHANGE_TO_NEG
                        
                        CHANGE_TO_NEG
                            NOT R4, R4
                            ADD R4, R4, #1
                        END_CHANGE_TO_NEG
                        
HALT

;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200

newline .FILL x0A
flag    .FILL #0        ;flag is set to 0 (positive). if first char is -, subtract 1 from flag
five_digits .FILL #5        ;counter set to 5. (5 MAX)

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
intro .STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
error_msg .STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
