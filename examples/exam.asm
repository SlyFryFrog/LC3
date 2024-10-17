.ORIG x3000

LDI R0, X_5000
LDI R1, X_5001


AND R2, R2, #0

NOT R1, R1
ADD R1, R1, #1  ; R1 = -R1
ADD R2, R0, R1  ; R2 = R0 - R1

; For int i = 0; i < 10; i++
AND R4, R4, #0
AND R3, R3, #0
; i = R4
; result = R3

ADD R4, R4, #10

LOOP
    ADD R3, R3, R2
    ADD R4, R4, #-1
    BRp LOOP
    HALT

X_5000 .FILL x5000
X_5001 .FILL x5001
.END