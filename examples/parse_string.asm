.ORIG x3000

START
    LEA R0, PROMPT_ENTER
    PUTS
    LEA R2, INPUT_PASSWORD          ; Bug where it wont erase old input
    BRnzp GET_INPUT_UNTIL_NL

GET_INPUT_UNTIL_NL
    GETC
    OUT

    LD R1, N_NL
    ADD R1, R0, R1
    BRz VERIFY

    ; Stores inputs into R2 and then increments the index by 1
    STR R0, R2, #0
    ADD R2, R2, #1
    BRnzp GET_INPUT_UNTIL_NL

VERIFY
    LEA R1, PASSWORD
    LEA R2, INPUT_PASSWORD  ; Must load the starting index

    VERIFY_LOOP
        LDR R0, R1, #0
        NOT R0, R0
        ADD R0, R0, #1

        LDR R4, R2, #0
        ADD R0, R0, R4

        BRnp START

 
        
        ADD R2, R2, #1
        ADD R1, R1, #1

        AND R0, R0, #0
        LDR R0, R1, #0
        BRz END_VERIFY
        BRnzp VERIFY_LOOP
    
    CLEAR
        LEA R2, INPUT_PASSWORD

        CLEAR_LOOP
            ; If position is 0 then all good
            LDR R0, R2, #0
            BRz START
            
            AND R0, R0, #0
            STR R0, R2, #0

            ADD R2, R2, #1
            BRnzp CLEAR_LOOP

    END_VERIFY
        AND R0, R0, #0
        LDR R0, R2, #0
        BRnp CLEAR

        LEA R0, PROMPT_SUCCESS
        PUTS
        HALT
        

PASSWORD .STRINGZ "1234"
N_NL .FILL #-10
INPUT_PASSWORD .BLKW #20
N_ASCII .FILL #-48

PROMPT_ENTER .STRINGZ "Enter your password: "
PROMPT_SUCCESS .STRINGZ "Login successfull!"

.END