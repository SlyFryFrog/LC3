.ORIG x3000

AND R0, R0, #0	; Counter
AND R1, R1, #0
ADD R1, R1, #10	; Max
AND R2, R2, #0	; Remaining
AND R3, R3, #0

LOOP ADD R0, R0, #1

	ADD R3, R3, #5	; Increment by 5

	NOT R4, R0
	ADD R4, R4, #1	; -R0

	ADD R2, R4, R1	; R1 - R0

	BRp LOOP	; If remaining iterations > 0

	BRz EXIT	; If remaining iterations == 0

EXIT
	HALT

.END
