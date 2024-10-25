.ORIG x3000

LDI R0, ST_X5000
LDI R1, ST_X5001

NOT R1, R1
ADD R1, R1, #1

ADD R0, R0, R1

AND R3, R3, #0  ; i
AND R4, R4, #0  ; result

BRnzp LOOP_MULTIPLY


LOOP_MULTIPLY
    ADD R4, R4, R0

    ADD R3, R3, #1
    ADD R2, R3, #-10

    BRnp LOOP_MULTIPLY

    STI R4, ST_X5002

    HALT

ST_X5000 .FILL x5000
ST_X5001 .FILL x5001
ST_X5002 .FILL x5002

ASCII .FILL #48

.END