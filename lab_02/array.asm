.ORIG x3000

; R0 -> used for Stringz
; R1 = size
; R2 = i -> index
; R3 -> used for temp value
; R4 = ASCII
; R5 = array

AND R2, R2, #0
AND R3, R3, #0

LEA R5, ARRAY_SIZE_ADDR  ; Load address of the size variable

LD R1, INTN   ; Load array size
LD R4, ASCII_OFFSET

LOOP BRz EXIT
	
	; Get input
		LEA R0, INPUT_NUM_MSG
		Puts

		GETC
		OUT

		; Subtract x0030 from input
		ADD R0, R0, R4

		; Stores input in array with offset of 0
		STR R0, R5, #0


		LEA R0, NL
		Puts

        ADD R2, R2, #1  ; i++
    	ADD R5, R5, #1 ; next element of array

	NOT R3, R2
	ADD R3, R3, #1
	ADD R3, R3, R1	; R1 - R2	size - i

	BRp LOOP	; if i < ARRAY_SIZE: continue

EXIT
	HALT


; Define variables
ARRAY_SIZE_ADDR .BLKW #20	; Size of array
INTN .FILL #5
ASCII_OFFSET .FILL #-48
INPUT_NUM_MSG .STRINGZ "Enter a number (0-9): "
NL .STRINGZ "\n"
.END
