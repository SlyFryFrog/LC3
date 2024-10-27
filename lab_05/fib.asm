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
        LDR R0, R6, #2      ; R0 = n
        STR R0, R6, #0      ; param int n

        JSR FIBONACCI       ; R6 = x5FFA    ; return address

    ADD R6, R6, #2      ; R6 = x5FFC
    LDR R0, R6, #-2     ; result = FIBONACCI(n);
    STR R0, R6, #0

    ;;;;;; PRINT CHARS ;;;;;;
        LEA R0, NL          ; \n
        PUTS

        LEA R0, FUNC_BEGIN
        PUTS                ; F(

        LDR R0, R6, #1      ; int n
        LD R1, N_ASCII
        NOT R1, R1
        ADD R1, R1, #1
        ADD R0, R0, R1
        OUT                 ; n
        
        LEA R0, FUNC_END    ; ) = 
        PUTS
    HALT

    ;;;;;; PRINT SETUP ;;;;;;
        ADD R6, R6, #-1     ; R6 = x5FFB
        LDR R0, R6, #1      ; R6 = x5FFC
        STR R0, R6, #0

    LEA R0, NL
    PUTS

HALT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; params int input
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRINT
    ;;;;;; INIT ;;;;;;
        ADD R6, R6, #-1
        STR R7, R6, #0  ; return adress

        ADD R6, R6, #-1
        STR R5, R6, #0	; previous frame pointer (R5)
    
    ADD R6, R6, #-1


    PRINT_LOOP
        FOR_I   ; for (int i = 0; i < 10; i++)

            BRzp FOR_I
RET

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

    ; if (n <= 1)
        BRn IF_N_LE_1
    ; else
        BRnzp ELSE

    IF_N_LE_1
        LDR R0, R6, #3
        STR R0, R6, #2
        BRnzp FIBONACCI_CLEANUP
    ELSE
        ;;;;;; FIBONACCI SETUP ;;;;;;
            ADD R6, R6, #-1 ; param int n
            LDR R0, R6, #4
            ADD R0, R0, #-1 ; n - 1
            STR R0, R6, #0  ; param int n;

            JSR FIBONACCI   ; return address param int n - 1

        ADD R6, R6, #2
        LDR R0, R6, #-2 ; (n - 1) result
        STR R0, R6, #2  ; result

        LDR R0, R6, #3  ; int n
        ADD R0, R0, #-2
        BRn IF_N_LE_1

        ;;;;;; FIBONACCI SETUP ;;;;;;
            ADD R6, R6, #-1
            LDR R0, R6, #4
            ADD R0, R0, #-2 ; n - 2
            STR R0, R6, #0  ; param int n;

            JSR FIBONACCI   ; return address param int n - 1
        ADD R6, R6, #2
        LDR R0, R6, #-2 ; (n - 2) result
        LDR R1, R6, #2  ; result

        ADD R1, R1, R0
        STR R1, R6, #2  ; result += F(n - 2)

        BRnzp FIBONACCI_CLEANUP
    ;;;;;; CLEANUP ;;;;;;
    FIBONACCI_CLEANUP
        LDR R5, R6, #0
        ADD R6, R6, #1
        LDR R7, R6, #0
        ADD R6, R6, #1  ; result
RET

GLOBAL_VARS		.BLKW #0	;	Global variables start here
STACK_PTR		.FILL x6000	;	STACK_PTR is a pointer to the bottom of the stack (x6000)
PROMPT_STR .STRINGZ "Enter a number n: "
FUNC_BEGIN .STRINGZ "F("
FUNC_END .STRINGZ  ") = "
NL .STRINGZ "\n"
N_ASCII .FILL #-48

.END