.ORIG x3000

;;;;; MAIN ;;;;;
    ;;;;;; Setup ;;;;;;
        ADD R6, R6, #-1 ;x5FFF
        STR R7, R6, #0

        ADD R6, R6, #-1 ; x5FFE
        STR R5, R6, #0

        ; Set frame ptr
        ADD R5, R6, #0
    ;;;;;;;;;;;;;;;;;;;

        ADD R6, R6, #-1
        LD R0, INT_X
        STR R0, R6, #0

        ADD R6, R6, #-1
        LD R0, INT_Y
        STR R0, R6, #0

        ADD R6, R6, #-1 ; return

        JSR POWER

        LDR R0, R6, #0
        STR R0, R5, #2  ; main return
        ADD R6, R6, #3  ; x5FFE
    ;;;;;;;;;;;;;;;;;;;

        LDR R5, R6, #0
        ADD R6, R6, #1  ; x5FFF
        LDR R7, R6, #0
        ADD R6, R6, #1  ; x6000
    ;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;
; int x, y
; ret pow
;;;;; POWER ;;;;;
POWER
    ;;;;;; Setup ;;;;;;
        ST R0, ST_R0
        ST R1, ST_R1
        ST R2, ST_R2
        ST R3, ST_R3

        ADD R6, R6, #-1 ;x5FFF
        STR R7, R6, #0

        ADD R6, R6, #-1 ; x5FFE
        STR R5, R6, #0

        ; Set frame ptr
        ADD R5, R6, #0
    ;;;;;;;;;;;;;;;;;;;

    ADD R6, R6, #-1
    AND R0, R0, #0
    ADD R0, R0, #1  ; int result = 1

    ; for (int i = 0; i < y; i++)
        ADD R6, R6, #-1
        AND R0, R0, #0
        STR R0,R6, #0   ; int i = 0;

        WHILE_TRUE
            
            LDR R1, R5, #2

            MULTIPLY
                BRnzp MULTIPLY

            BRnzp WHILE_TRUE
    

    ;;;;;; Return ;;;;;;
        LDR R5, R6, #0
        ADD R6, R6, #1

        LDR R7, R6, #0
        ADD R6, R6, #1
    
        LD R0, ST_R0
        LD R1, ST_R1
        LD R2, ST_R2
        LD R3, ST_R3

        RET
    ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;

STACKE_BASE .FILL x6000
INT_X .FILL #5
INT_Y .FILL #3

ST_R0 .BLKW #1
ST_R1 .BLKW #1
ST_R2 .BLKW #1
ST_R3 .BLKW #1

.END