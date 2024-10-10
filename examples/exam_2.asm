.ORIG x3000


CREATE_PASSWORD

    BRnzp GET_PASSWORD

GET_PASSWORD
    GET_INPUT_UNTIL_NL
        ; Gets input
        GETC
        OUT

        ADD R0, R0, R2              ; R0 -= 48
        ADD R1, R1, #0
        BRz IS_FIRST_CHAR
        BRnzp ELSE

        IS_FIRST_CHAR
            ADD R0, R0, #0
            BRn GET_INPUT_UNTIL_NL
            BRz IS_ZERO

            ADD R1, R1, R0              ; R1 += R0

            BRnzp GET_INPUT_UNTIL_NL

            IS_ZERO
                ; When 0 is inputed, wont print newline so manually need to
                LD R0, NEWLINE
                OUT
                AND R0, R0, #0
                BRnzp FI

            ELSE        
                ADD R0, R0, #0
                BRn FI

    LEA R0, UNSUCC
    PUTS
    ; Loops until correct
    BRnp GET_PASSWORD

    LEA R0, SUCC
    PUTS
    HALT


GET_INPUT_UNTIL_NL
    ; Gets input
    GETC
    OUT

    ADD R0, R0, R2              ; R0 -= 48
    ADD R1, R1, #0
    BRz IS_FIRST_CHAR
    BRnzp ELSE

    IS_FIRST_CHAR
        ADD R0, R0, #0
        BRn GET_INPUT_UNTIL_NL
        BRz IS_ZERO

        ADD R1, R1, R0              ; R1 += R0

        BRnzp GET_INPUT_UNTIL_NL

        IS_ZERO
            ; When 0 is inputed, wont print newline so manually need to
            LD R0, NEWLINE
            OUT
            AND R0, R0, #0
            BRnzp FI

        ELSE        
            ADD R0, R0, #0
            BRn FI
; Save callee state
ST R1, GETNUM_R1
ST R2, GETNUM_R2
ST R3, GETNUM_R3
ST R7, GETNUM_R7



PASS_ARRAY .BLKW #20    ; Reserves 20 spaces of memory

UNSUCC .STRINGZ "Incorrect password."
SUCC .STRINGZ "Correct password"
ASCII_OFFSET .FILL #-48
.END