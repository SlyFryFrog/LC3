.ORIG x3000

; IF STATEMENT
; nzp or some combination of the 3
; n - Negative condition
; z - Zero condition
; p - Positive condition

ADD R0, R0, #3

LOOP ADD R0, R0, #-1 ; Label
	BRp LOOP

.END
