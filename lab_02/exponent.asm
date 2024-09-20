.ORIG x3000
; R0 = x
; R1 = y
; R2 = i
; R3 = j
; R4 = accumulator/result
; R5 = loopvar


; Exponential to addition
; 2^3 = 2 * 2 * 2
; = 2 + 2 + 2 + 2
; = 4 + 2 + 2
; = 6 + 2 = 8

; 5^3
; 5 + 5 + 5 + 5 + 5
; 25 + 25 + 25 + 25 + 25

; 7^3
; 7 + 7 + 7 + 7 + 7 + 7 + 7
; 49 + 49 + 49 + 49 + 49 + 49 = 49

LD R0, INTX
LD R1, INTY

AND R2, R2, #0 ; R2 = 0
AND R3, R3, #0 ; R3 = 0
AND R4, R4, #0 ; R4 = 0
AND R5, R5, #0

; Base Cases
; x^0 = 1
; 0^y = 0

; if y == 0
    ADD R1, R1, #0 ; R1 + 0
    BRz YZERO
; elif x == 0
    ADD R0, R0, #0 ; R0 + 0
    BRz XZERO


ADD R5, R0, #0  ; current = x

LOOP

    MULTIPLY
        ADD R3, R3, #1  ; j++

        ADD R4, R4, R5  ; R4 += R5

        NOT R6, R0
        ADD R6, R6, #1  ; -R0

        ADD R6, R6, R3
        BRn MULTIPLY
    ENDMULTIPLY
    
    AND R5, R5, #0
    ADD R5, R4, #0

    ADD R2, R2, #1 ; i++
    NOT R6, R1
    ADD R6, R6, #1
    ADD R6, R6, R2
    ADD R6, R6, #1

    BRn LOOP
ENDLOOP

BRnzp EXIT

YZERO   ; if y == 0
    ADD R4, R4, #1 ; R4 += 1
    BRnzp EXIT

XZERO   ; if x == 0
    ADD R4, R4, #0 ; R4 += 0
    BRnzp EXIT

EXIT
    STI R4, RESULT ; store R4 in RESULT's address
    HALT


; Variables
INTX .FILL #2
INTY .FILL #4
RESULT .FILL x8000

.END