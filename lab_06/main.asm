.ORIG x3000

;;;;;; PTR SETUP ;;;;;;
LD R6, STACK_PTR
LEA R4, GLOBAL_PTR

LD R0, CHAR_S
STR R0, R4, #0
ADD R4, R4, #-1

;;;;;;;;;;;;;;;;;;;;;;;

MAIN
    ;;;;;; Setup ;;;;;;
        ADD R6, R6, #-1 ;x5FFF
        STR R7, R6, #0

        ADD R6, R6, #-1 ; x5FFE
        STR R5, R6, #0

        ; Set frame ptr
        ADD R5, R6, #0
    ;;;;;;;;;;;;;;;;;;;

    ; node_t *head;
    ADD R6, R6, #-1     ; x5FFD

    ; char selection = 's';     // 's' = 115
    ADD R6, R6, #-1     ; x5FFC
    LDR R0, R4, #1
    STR R0, R6, #0

    ;;;;;; while(selection != 'q') ;;;;;;


HALT

STACK_PTR .FILL x6000
GLOBAL_PTR .FILL x5000

CHAR_S .FILL #115

.END