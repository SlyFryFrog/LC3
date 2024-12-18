.ORIG x3000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; int main()
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Main's return value
LD R6, STACK_BASE		; R6 = x6000

; Main's return address
ADD R6, R6, #-1			; R6 = x5FFF
STR R7, R6, #0

; Previous frame pointer
ADD R6, R6, #-1			; R6 = x5FFE
STR R5, R6, #0
ADD R5, R6, #0  ; set frame pointer

    ADD R6, R6, #-1 ; param(A)
    LD R0, PARAM_A
    STR R0, R6, #0
    
    ADD R6, R6, #-1 ; param(B)
    LD R0, PARAM_B
    STR R0, R6, #0

    ADD R6, R6, #-1 ; param(C)
    LD R0, PARAM_C
    STR R0, R6, #0

    ADD R6, R6, #-1   ; return
    
    JSR FIND_VOLUME

    ; Store FIND_VOLUME result
    LDR R0, R6, #0    ; return
    STR R0, R5, #2
    ADD R6, R6, #1    ; pop return

; Pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1			; R6 = x5FFF

; Pop return address
LDR R7, R6, #0
ADD R6, R6, #1			; R6 = x6000

HALT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

STACK_BASE .FILL x6000
PARAM_A .FILL #2
PARAM_B .FILL #4
PARAM_C .FILL #7

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; <FIND_VOLUME>
; <args> A, B, C
; <return> Volume
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FIND_VOLUME
    ADD R6, R6, #-1
    STR R7, R6, #0	; return address (R7)

    ADD R6, R6, #-1
    STR R5, R6, #0	; previous frame pointer (R5)
    ADD R5, R6, #0  ; set frame pointer

    ST R0, STORE_R0
    ST R1, STORE_R1
    ST R2, STORE_R2
    ST R3, STORE_R3
    ST R4, STORE_R4

    ADD R6, R6, #-1
    AND R0, R0, #0  
    STR R0, R6, #0  ; result = 0;

    ; for (int i = A; i > 0; i--)
    ADD R6, R6, #-1
    LDR R0, R5, #5
    BRn RETURN_NEG  ; if (result < 0)
    STR R0, R6, #0  ; i = A
    WHILE_A
        LDR R0, R6, #0
        ADD R0, R0, #-1
        STR R0, R6, #0  ; i--;
        BRn BREAK_A

        ; for (int j = 0; j < B; j++)
        ADD R6, R6, #-1
        LDR R0, R5, #4
        BRn RETURN_NEG  ; if (result < 0)
        STR R0, R6, #0  ; int j = B

        ADD R6, R6, #-1
        LDR R0, R5, #3
        BRn RETURN_NEG  ; if (result < 0)
        STR R0, R6, #0  ; int C;

        WHILE_B
            LDR R0, R6, #1
            ADD R0, R0, #-1
            STR R0, R6, #1  ; j--;
            BRn BREAK_B

            LDR R0, R6, #3  ; result
            LDR R1, R6, #0  ; C
            ADD R0, R0, R1  ; result += C
            STR R0, R6, #3
            BRnzp WHILE_B
        BREAK_B

        ADD R6, R6, #1  ; pop C
        ADD R6, R6, #1  ; pop j

        BRnzp WHILE_A

    BREAK_A
        ADD R6, R6, #1  ; pop i
        LDR R0, R6, #0  ; result

        STR R0, R5, #2  ; return = result
        ADD R6, R6, #1  ; pop result

        BRnzp FIND_VOLUME_RETURN

    RETURN_NEG
        ADD R6, R5, #0  ; pop all local vars
        AND R0, R0, #0
        ADD R0, R0, #-1
        STR R0, R6, #2  ; result
        BRnzp FIND_VOLUME_RETURN

FIND_VOLUME_RETURN
    LDR R5, R6, #0
    ADD R6, R6, #1

    LDR R7, R6, #0
    ADD R6, R6, #1

    LD R0, STORE_R0
    LD R1, STORE_R1
    LD R2, STORE_R2
    LD R3, STORE_R3
    LD R4, STORE_R4

RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

STORE_R0 .BLKW #1
STORE_R1 .BLKW #1
STORE_R2 .BLKW #1
STORE_R3 .BLKW #1
STORE_R4 .BLKW #1

.END