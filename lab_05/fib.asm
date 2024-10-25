.ORIG x3000

LD R6, STACK_PTR			;	LOAD the pointer to the bottom of the stack in R6	(R6 = x6000)
LEA R4, GLOBAL_VARS			;	MAKE your global var pointer R4 point to globals	(R4 = ADDRESS(GLOBAL_VARS))

MAIN
    ADD R6, R6, #-1		; R6 = x5FFF
    STR R7, R6, #0		; main return address (R7)

    ADD R6, R6, #-1		; R6 = x5FFE
    ADD R5, R6, #0		; R5 = R6 = x5FFE
    STR R5, R6, #0		; previous frame pointer (R5)
    ; setting frame pointer (R5)
    ADD R5, R6, #0		; R5 = R6 = x5FFE

    ; Prompt user
    LEA R0, PROMPT_STR
    PUTS

    ; Get user input
    ; int n = scanf - 48
    ADD R6, R6, #-1     ; R6 = x5FFD

    GETC
    OUT
    LD R1, N_ASCII
    ADD R0, R0, R1

    STR R0, R6, #0

    ; int result;
    ADD R6, R6, #-1     ; R6 = x5FFC

    ;;;;;; FIBONACCI SETUP ;;;;;;
        ADD R6, R6, #-1     ; R6 = x5FFB
        LDR R0, R6, #1      ; R0 = n
        STR R0, R6, #0      ; param int n

        JSR FIBONACCI       ; R6 = x5FFA    ; return address

    ADD R6, R6, #2      ; R6 = x5FFC
    LDR R0, R6, #-2     ; result = FIBONACCI(9);
    STR R0, R6, #0

    ;;;;;; PRINT RESULT ;;;;;;


    LEA R0, NL
    PUTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; params int n
; returns fib(n - 1) + fib(n - 2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FIBONACCI
    ;;;;;; INIT ;;;;;;
        ADD R6, R6, #-1 ; return value

        ADD R6, R6, #-1
        STR R7, R6, #0	; sum of squares return address (R7)

        ADD R6, R6, #-1
        STR R5, R6, #0	; previous frame pointer (R5)

    LDR R0, R6, #3  ; int n;
    ADD R0, R0, #-1
    ; if (n == 0)
        BRn IF_N_0
    ; elif (n == 1)
    BRz IF_N_1
    ; else
    BRnzp ELSE

    IF_N_0
        AND R0, R0, #0
        STR R0, R6, #2
        BRnzp FIBONACCI_CLEANUP
    IF_N_1
        AND R0, R0, #0
        ADD R0, R0, #1
        STR R0, R6, #2
        BRnzp FIBONACCI_CLEANUP
    ELSE

        BRnzp CALL_FIBONACCI

    ;;;;;; FIBONACCI SETUP ;;;;;;
    CALL_FIBONACCI
        ADD R6, R6, #-1
        LDR R0, R6, #0  ; FIXME
        STR R0, R6, #0  ; param int n;

        ADD R6, R6, #-1 ; return value
        JSR FIBONACCI
        ADD R6, R6, #2
        ; do something with result

    ;;;;;; CLEANUP ;;;;;;
    FIBONACCI_CLEANUP
        LDR R5, R6, #0
        ADD R6, R6, #1
        LDR R7, R6, #0
        ADD R6, R6, #1
RET

GLOBAL_VARS		.BLKW #0	;	Global variables start here
STACK_PTR		.FILL x6000	;	STACK_PTR is a pointer to the bottom of the stack (x6000)
PROMPT_STR .STRINGZ "Enter a number n: "
NL .STRINGZ "\n"
N_ASCII .FILL #-48

.END