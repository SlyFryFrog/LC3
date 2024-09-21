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

; Get x
    LEA R0, INPUT_X_MSG
    PUTS

    GETC
    OUT

    ADD R0, R0, R3

    STI R0, X_ADDR
    LDI R1, X_ADDR  ; R1 = x

    LEA R0, NL      ; \n
    PUTS

; Get y
    LEA R0, INPUT_Y_MSG
    PUTS

    GETC
    OUT
 
    ADD R0, R0, R3

    STI R0, Y_ADDR
    LDI R2, Y_ADDR  ; R2 = y

    LEA R0, NL      ; \n
    PUTS


; R3 = current value

AND R3, R3, #0
ADD R4, R1, #0

EXPONENT

    BRz I_ZERO
    BRnzp INNER_EXPONENT

    I_ZERO
        AND R0, R0, #0
        ADD R0, R2, #0

        BRz Y_ZERO

        AND R3, R3, x0000
        ADD R3, R1, x0000  ; R6 = x
        BRnzp INNER_EXPONENT
    END_I_ZERO

    INNER_EXPONENT
        ADD R4, R4, R3  ; result += current_value

        ADD R6, R6, x0001  ; j++

        NOT R0, R1
        ADD R0, R0, x0001  ; -x
        ADD R0, R0, R6  ; x_copy = j - x_copy
        ADD R0, R0, x0001

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
    ADD R4, R4, #1
    STI R4, RESULT_ADDR
    BRnzp EXIT

EXIT
    HALT


X_ADDR .FILL x8000
Y_ADDR .FILL x8001
RESULT_ADDR .FILL x8002
ASCII_OFFSET .FILL #-48

INPUT_X_MSG .STRINGZ "Input x: "
INPUT_Y_MSG .STRINGZ  "Input y: "
NL .STRINGZ  "\n"
.END
