;=================================================
; Name: Kelley Zhou
; Email: kzhou034@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 23
; TA: Shirin
; 
;=================================================
;
; Hello World example program
; also illustrates how to use PUTS (aka Trap x22)
;
.ORIG x3000
; ----------
; Instructions
; ----------
    LEA r0, MSG_TO_PRINT  ;r0 <- the location of the label: MSG_TO_PRINT
    PUTS     ;Prints string defined as MSG_TO_PRINT
    
    HALT     ;Terminate program
; ----------
; Local data
; ----------
    MSG_TO_PRINT    .STRINGZ "Hello world!!!\n" ;store 'H' in an address labelled
                            ;MSG_TO_PRINT and then each
                            ;character ('e', 'l', 'l', 'o', ' ', 'w', ...) in
                            ;it's own (consecutive) memory
                            ;address, followed by #0 at the end
                            ; of the string to mark the end of the 
                            ;string
.END