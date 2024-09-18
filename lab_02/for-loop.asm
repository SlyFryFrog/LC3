.ORIG x3000

; Reset registers to be x0000
AND R0, R0, #0	; i
AND R3, R3, #0	; Result

; Set variables
LD R1, MAX 		; Max number of iterations
LD R4, INCREMENT_BY

; if i == max
    NOT R5, R0      ; ~R0
    ADD R5, R5, #1  ; -R0
	ADD R2, R5, R1

; While loop for incrementing by x0005
LOOP BRz EXIT		; Continue while int i != 0
	ADD R0, R0, #1	; i++

	ADD R3, R3, R4	; Result += Increment

	NOT R5, R0		; ~R0
	ADD R5, R5, #1	; -R0

	ADD R2, R5, R1	; R1 - R0

	BRp LOOP	; If remaining iterations > 0

EXIT
	STI R3, STORE_x8001
	HALT

; Variables

INCREMENT_BY .FILL #5
MAX .FILL #10

STORE_x8001 .FILL x8001

.END
