.ORIG x3000

LD      R0, VALUE      ; Load the value at the label "VALUE" into R0
LD      R1, VALUE      ; Load the value at the label "VALUE" into R1
AND	R3, R3, #0

VALUE .FILL #10          ; Store the value 10 in memory

NOT	R3, R0		; R3 = ~R0
ADD	R3, R3, #1	; R3 = ~R0 + 1 ; R3 = R3 + 1
ADD     R3, R3, R1      ; R3 = !R0 + R1

BRz     SKIP_IF_EQUAL
BRnp    SKIP_ELSE_NOT_EQUAL

SKIP_IF_EQUAL           ; Set R3 to 5
        AND R3, R3, #0
        ADD R3, R3, #5
        HALT

SKIP_ELSE_NOT_EQUAL     ; Set R3 to -3
        AND R3, R3, #0
        ADD R3, R3, #-3
        HALT

.END
