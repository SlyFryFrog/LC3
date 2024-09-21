.ORIG x3000


; R1    x
; R2    y
; R3    ASCII Offset
; R4    result
; R5    i
; R6    j
; R0    current value being added


LD R3, ASCII_OFFSET

AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R1, INTX  ; R1 = x
LD R2, INTY  ; R2 = y


; R3 = current value

AND R3, R3, #0
ADD R4, R1, #0

AND R0, R0, #0
ADD R0, R2, #0
  
BRz Y_ZERO

EXPONENT

    BRz I_ZERO
    BRnzp INNER_EXPONENT

    I_ZERO
        AND R3, R3, #0
        ADD R3, R1, #0  ; R6 = x
        
        BRnzp INNER_EXPONENT
    END_I_ZERO

    INNER_EXPONENT
        ADD R4, R4, R3  ; result += current_value

        ADD R6, R6, #1  ; j++

        NOT R0, R1
        ADD R0, R0, #1  ; -x
        ADD R0, R0, R6  ; x_copy = j - x_copy
        ADD R0, R0, #1

        BRn INNER_EXPONENT
    END_INNER_EXPONENT

    AND R6, R6, #0  ; j = 0
    AND R3, R3, #0
    ADD R3, R4, #0  ; current_value = result

    ADD R5, R5, #1  ; i++

    NOT R0, R2
    ADD R0, R0, #1
    ADD R0, R0, R5  ; y_length = i - y_length

    BRn EXPONENT
    
    STI R4, RESULT_ADDR ; store R4 in memory

    BRnzp EXIT
END_EXPONENT

Y_ZERO
    AND R4, R4, #0
    ADD R4, R4, #1
    STI R4, RESULT_ADDR
    BRnzp EXIT

EXIT
    HALT


; Variables
INTX .FILL #5
INTY .FILL #0
RESULT_ADDR .FILL x8000
ASCII_OFFSET .FILL #-48

.END