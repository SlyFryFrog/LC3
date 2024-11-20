.ORIG x3000

;;;;;; PTR SETUP ;;;;;;
LD R6, STACK_PTR
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
    AND R0, R0, #0
    STR R0, R6, #0

    ; char selection = 's';     // 's' = 115
    ADD R6, R6, #-1     ; x5FFC
    LD R0, CHAR_S
    STR R0, R6, #0

    ;;;;;; while(selection != 'q') ;;;;;;
    WHILE_NOT_Q
        ;;; PRINT OPTIONS ;;;
            LEA R0, STR_1
            PUTS
            
            LEA R0, STR_2
            PUTS

            LEA R0, STR_3
            PUTS

            LEA R0, STR_4
            PUTS

            LEA R0, STR_5
            PUTS

            LEA R0, STR_6
            PUTS
            
            ;;; GET_INPUT ;;;
                GETC
                OUT
                STR R0, R6, #0  ; x5FFC
                LD R0, STR_NL
                OUT

            IF_P
                LDR R0, R6, #0
                LD R1, CHAR_P
                NOT R1, R1
                ADD R1, R1, #1
                ADD R1, R0, R1
                BRnp ELSE_IF_A

                    ADD R6, R6, #-1 ; **head
                    LDR R0, R6, #2
                    STR R0, R6, #0
                    JSR PRINT_LIST

                BRnzp CONTINUE
            ELSE_IF_A
                LDR R0, R6, #0
                LD R1, CHAR_A
                NOT R1, R1
                ADD R1, R1, #1
                ADD R1, R0, R1
                BRnp ELSE_IF_R

                ADD R6, R6, #-1 ; input number

                LEA R0, STR_7
                PUTS
            
                TRAP x40
                STR R0, R6, #0      ; x5FFB
                TRAP x41

                LEA R0, STR_NL
                PUTS

                    ADD R6, R6, #-1 ; x5FFA
                    ADD R0, R6, #3  ; **head - x5FFD
                    STR R0, R6, #0

                    ADD R6, R6, #-1 ; x5FF9
                    LDR R0, R6, #2  ; input num
                    STR R0, R6, #0
                    JSR ADD_VALUE
                    ADD R6, R6, #3  ; x5FFC

                BRnzp CONTINUE
            ELSE_IF_R
                LDR R0, R6, #0
                LD R1, CHAR_R
                NOT R1, R1
                ADD R1, R1, #1
                ADD R1, R0, R1
                BRnp ELSE_IF_Q

                JSR REMOVE_VALUE
                
                BRnzp CONTINUE
            ELSE_IF_Q
                LDR R0, R6, #0
                LD R1, CHAR_Q
                NOT R1, R1
                ADD R1, R1, #1
                ADD R1, R0, R1
                BRnp WHILE_NOT_Q
                
                JSR BREAK

                LEA R0, STR_NL
                PUTS
                BRnzp CONTINUE
            CONTINUE
                LEA R0, STR_NL
                PUTS
                BRnzp WHILE_NOT_Q
    BREAK
HALT

STACK_PTR .FILL x6000
GLOBAL_PTR .FILL x5000

CHAR_A .FILL #97
CHAR_P .FILL #112
CHAR_Q .FILL #113
CHAR_R .FILL #114
CHAR_S .FILL #115

STR_1 .STRINGZ "Available options:\n"
STR_2 .STRINGZ "p - Print linked list\n"
STR_3 .STRINGZ "a - Add value to linked list\n"
STR_4 .STRINGZ "r - Remove value from linked list\n"
STR_5 .STRINGZ "q - Quit\n"
STR_6 .STRINGZ "Choose an option: "
STR_7 .STRINGZ "Type a number to add: "
STR_8 .STRINGZ "Type a number to remove: "
STR_NL .STRINGZ "\n"

;;; void printList ;;;
; params node_t **head
;;;;;;;;;;;;;;;;;;;;;;
PRINT_LIST
    ADD R6, R6, #-1
    STR R7, R6, #0	; return address (R7)

    ADD R6, R6, #-1
    STR R5, R6, #0	; previous frame pointer (R5)
    ADD R5, R6, #0  ; set frame pointer

    ; if (*head == NULL)
    LDR R0, R6, #2  ; *head
    BRz EMPTY

    EMPTY
        LEA R0, STR_EMPTY
        PUTS
        BRnzp RETURN_PRINT_LIST


    RETURN_PRINT_LIST
        LDR R5, R6, #0
        ADD R6, R6, #1

        LDR R7, R6, #0
        ADD R6, R6, #1
RET

STR_EMPTY .STRINGZ "The list is empty.\n"

;;; void addValue ;;;
; params node_t **head [x5FFA], int added [x5FF9]
;;;;;;;;;;;;;;;;;;;;;
ADD_VALUE           ; x5FF9
    ADD R6, R6, #-1 ; x5FF8
    STR R7, R6, #0	; return address (R7)

    ADD R6, R6, #-1 ; x5FF7
    STR R5, R6, #0	; previous frame pointer (R5)
    ADD R5, R6, #0  ; set frame pointer

    LDR R0, R5, #3  ; x5FFA
    LDR R0, R0, #0

    BRnp ADD_NUM

    ; else, *head == NULL
        LD R0, LIST_BASE    ; x8000

        LDR R1, R5, #3      ; x5FFD <- x5FFA

        STR R0, R1, #0      ; x8000 -> x5FFD

        LDR R0, R6, #3      ; x5FFD <- x5FFA
        LDR R0, R0, #0      ; x8000 <- x5FFD
        LDR R1, R6, #2      ; int added
        STR R1, R0, #0      ; int -> x8000

        AND R1, R1, #0      ; x0
        STR R1, R0, #1      ; x8001
        BRnzp RETURN_ADD_VALUE

    ADD_NUM
        ADD R6, R6, #-1
        LDR R0, R5, #3      ; x5FFD <- x5FFA
        LDR R0, R0, #0      ; x8000 <- x5FFD
        STR R0, R6, #0      ; *head -> current;

        WHILE_NULL
            LDR R0, R6, #0  ; x####                 ; x8000
            ADD R0, R0, #1  ; x#### + 1             ; x8001
            LDR R0, R0, #0  ; *next <- x#### + 1    ; null || x8002 <- x8001
            BRz BREAK_WHILE_NULL

            STR R0, R6, #0  ; current = current->next

            BRnzp WHILE_NULL

        BREAK_WHILE_NULL
            LDR R0, R6, #0

            LDR R1, R6, #0 
            ADD R1, R1, #2  ; x#### + 2 -> next

            STR R1, R0, #1

            LDR R1, R5, #2  ; input, x5FF9
            STR R1, R0, #2  ; next <- input

            AND R1, R1, #0
            STR R1, R0, #3

            ADD R6, R6, #1  ; pop current
            BRnzp RETURN_ADD_VALUE

    RETURN_ADD_VALUE
        LDR R5, R6, #0
        ADD R6, R6, #1

        LDR R7, R6, #0
        ADD R6, R6, #1
RET

;;; void removeValue ;;;
; params node_t **head, int removed
;;;;;;;;;;;;;;;;;;;;;;;;
REMOVE_VALUE
    ADD R6, R6, #-1
    STR R7, R6, #0	; return address (R7)

    ADD R6, R6, #-1
    STR R5, R6, #0	; previous frame pointer (R5)
    ADD R5, R6, #0  ; set frame pointer

    
    REMOVE_VALUE_RETURN
        LDR R5, R6, #0
        ADD R6, R6, #1

        LDR R7, R6, #0
        ADD R6, R6, #1
RET

LIST_BASE .FILL x8000

.END
