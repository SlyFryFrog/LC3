.ORIG x3000

LD      R0, VALUE_2    	; Load the value at the label "VALUE_#" into R0
LD      R1, VALUE_2    	; Load the value at the label "VALUE_#" into R1
AND	R3, R3, #0

NOT	R3, R0		; R3 = ~R0
ADD	R3, R3, #1	; R3 = ~R0 + 1 ; R3 = -R0
ADD     R3, R3, R1      ; R3 = R1 - R0

BRz     TRUE		; If answer == 0
BRnp    FALSE		; If answer != 0

TRUE           ; Set R3 to 5
        AND R3, R3, #0
        ADD R3, R3, #5
	STI R3, STORE_x8002
        HALT

FALSE     ; Set R3 to -3
        AND R3, R3, #0
        ADD R3, R3, #-3
        STI R3, STORE_x8002
        HALT

; Variables
STORE_x8002 .FILL x8002
VALUE_1 .FILL #10          ; Store the value 10 in memory
VALUE_2 .FILL #-5

.END
