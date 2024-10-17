.ORIG x3000

START

LEA R0, PROMPT_STR
PUTS

LEA R1, ARRAY
AND R2, R2, #0

GET_INPUT_UNTIL_NL

    FILL_ARRAY_LOOP
        LDR R0, R1, #0  ; Loads index
        GETC
        OUT

        ADD R5, R0, #-10  ; Check for enter key
        BRz PRINT
        
        ; Add -32
        LD R5, ASCII_UPPER_LOWER
        ADD R0, R0, R5  ; Subtracts 32
        BRz ADD_SPACE
        BRnp ADD_CAPITAL

        ADD_SPACE
            NOT R5, R5
            ADD R5, R5, #1

            AND R0, R0, #0
            ADD R0, R0, R5
            BRnzp STORES
        ADD_CAPITAL
            ; Add -32
            BRnzp STORES
        STORES
            STR R0, R1, #0  ; Stores index

            ADD R1, R1, #1  ; Shifts index
            
            ADD R2, R2, #1  ; Shifts Length
        BRnp FILL_ARRAY_LOOP
    
    BRnzp PRINT

CLEAR
    LEA R2, ARRAY

    CLEAR_LOOP  ; Resets array
        ; If position is 0 then all good
        LDR R0, R2, #0
        BRz START
        
        AND R0, R0, #0
        STR R0, R2, #0

        ADD R2, R2, #1
        BRnzp CLEAR_LOOP


PRINT
    LEA R0, ARRAY
    PUTS

    LEA R0, NEWLINE
    PUTS
    BRnzp CLEAR

    BRnzp START

PROMPT_STR .STRINGZ "Please type something: "
NEWLINE .STRINGZ "\n"
ARRAY .BLKW #100
ASCII_UPPER_LOWER .FILL #-32

.END