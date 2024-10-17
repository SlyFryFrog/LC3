.ORIG x3000

START
LEA R1, STRING

LDR R0, R1, #0

ITERATE
    OUT

    ADD R1, R1, #1
    LDR R0, R1, #0  ; Checks next index, ends if null
    BRnp ITERATE

    LEA R0, NL_CHAR
    PUTS
    LD R3, ENTER_ASCII

    ; Waits to print until enter key is pressed
    GET_INPUT
        GETC
        ADD R0, R0, R3
        BRz START
        BRnp FINISH

    FINISH
        HALT

STRING .STRINGZ "HELLO"
NL_CHAR .STRINGZ "\n"
ENTER_ASCII .FILL #-10

.END