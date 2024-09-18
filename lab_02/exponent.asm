.ORIG x3000

; IF STATEMENT
; nzp or some combination of the 3
; n - Negative condition
; z - Zero condition
; p - Positive condition

LEA R1, X         ; Load the address of x into R0
LEA R2, Y         ; Load the address of y into R1

AND R0, R0, #0
ADD R0, R0, #3

AND R3, R3, #0


; Data
X .FILL x0021
Y .FILL x0002


LOOP ADD R0, R0, #-1
	ADD R3, R3, R1

	NOT R4, R2
	ADD R4, R4, #1

	ADD R4, R4, R0	; R2 - R0

	BRp LOOP

;LDI R5, x8000
;STR R3, R5, #0

.END
