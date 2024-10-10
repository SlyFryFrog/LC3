        .ORIG x3000

; Array stored in memory
ARRAY   .FILL x0001  ; Element 1
        .FILL x0002  ; Element 2
        .FILL x0003  ; Element 3
        .FILL x0004  ; Element 4
        .FILL x0005  ; Element 5
        .FILL x0006  ; Element 6
        .FILL x0007  ; Element 7
        .FILL x0008  ; Element 8
        .FILL x0009  ; Element 9
        .FILL x000A  ; Element 10

; Initialize the base address of the array and loop counter
START
        LEA R5, ARRAY   ; Load base address of the array into R0
        AND R1, R1, #0  ; Clear R1 to use as index/counter
        LD R6, ASCII
LOOP    LDR R0, R5, #0  ; Load the current element of the array into R3
        ADD R0, R0, R6  ; array[i] += 48
        OUT

        ADD R5, R5, #1  ; Move to the next element in memory
        ADD R1, R1, #1  ; Increment counter
        ADD R4, R1, #-10 ; Check if counter has reached 10
        BRnp LOOP       ; If not, branch back to LOOP
        BRnzp START

ASCII .FILL #48
; End of program
HALT

        .END

