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

    ; ADD R6, R6, #-1
    ; LDR R0, R6, #_
    ; STR R0, R6, #0

    ; ADD R6, R6, #-1   ; return
    
    JSR FUNC_NAME

    ; LDR R0, R6, #0    ; return
    ; STR R0, R6, #_
    ; ADD R6, R6, #1    ; pop return

; Pop previous frame pointer
LDR R5, R6, #0
ADD R6, R6, #1			; R6 = x5FFF

; Pop return address
LDR R7, R6, #0
ADD R6, R6, #1			; R6 = x6000

; Store FUNC_NAME result
; LDR R0, R6, #_
; STR R0, R6, #0

HALT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

STACK_BASE .FILL x6000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; <func_name>
; <args>
; <return>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FUNC_NAME
    ADD R6, R6, #-1
    STR R7, R6, #0	; return address (R7)

    ADD R6, R6, #-1
    STR R5, R6, #0	; previous frame pointer (R5)
    ADD R5, R6, #0  ; set frame pointer

    ST R1, STORE_R1
    ST R2, STORE_R2
    ST R3, STORE_R3
    ST R4, STORE_R4



FUNC_NAME_RETURN
    LDR R5, R6, #0
    ADD R6, R6, #1

    LDR R7, R6, #0
    ADD R6, R6, #1

    LD R1, STORE_R1
    LD R2, STORE_R2
    LD R3, STORE_R3
    LD R4, STORE_R4

    ; LDR R0, R6, #_
    ; STR R0, R6, #0    ; return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

STORE_R1 .BLKW #1
STORE_R2 .BLKW #1
STORE_R3 .BLKW #1
STORE_R4 .BLKW #1

.END