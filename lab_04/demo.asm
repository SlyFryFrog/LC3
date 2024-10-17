.ORIG x3000
LD R6, STACK_BASE		; R6 = x6000

; main's return address (R7)
ADD R6, R6, #-1			; R6 = x5FFF
STR R7, R6, #0

; previous frame pointer (R5)
ADD R6, R6, #-1			; R6 = x5FFE
STR R5, R6, #0

; setting frame pointer (R5)
ADD R5, R6, #0			; R5 = R6 = x5FFE

; int x
AND R0, R0, #0			; R0 = 0
ADD R0, R0, #10			; R0 = 10
ADD R6, R6, #-1			; R6 = x5FFD
STR R0, R6, #0

; int y
AND R0, R0, #0			; R0 = 0
ADD R0, R0, #11			; R0 = 10
ADD R6, R6, #-1			; R6 = x5FFC
STR R0, R6, #0

; int val
ADD R6, R6, #-1			; R6 = x5FFB

; int a
LDR R0, R5, #-1			; R0 = int x = #10
ADD R0, R0, #10			; R0 = x + 10
ADD R6, R6, #-1			; R6 = x5FFA
STR R0, R6, #0

; int b
LDR R0, R5, #-2			; R0 = int y = #11
ADD R6, R6, #-1			; R6 = x5FF9
STR R0, R6, #0

JSR MAX

; pop max's return value
LDR R0, R6, #0
ADD R6, R6, #3			; R6 = x5FFB

; int val
STR R0, R5, #-3

; main's return value
STR R0, R5, #2

; pop int val, int y, int x
ADD R6, R6, #3			; R6 = x5FFE

; pop previous frame pointer (R5)
LDR R5, R6, #0
ADD R6, R6, #1			; R6 = x5FFF

; pop main's return address (R7)
LDR R7, R6, #0
ADD R6, R6, #1			; R6 = x6000

HALT

STACK_BASE .FILL x6000

MAX
; max's return value
ADD R6, R6, #-1			; R6 = x5FF8

; max's return address (R7)
ADD R6, R6, #-1			; R6 = x5FF7
STR R7, R6, #0

; previous frame pointer (R5)
ADD R6, R6, #-1			; R6 = x5FF6
STR R5, R6, #0

; setting frame pointer (R5)
ADD R5, R6, #0			; R5 = R6 = x5FF6

; save R0
ADD R6, R6, #-1			; R6 = x5FF5
STR R0, R6, #0

; save R1
ADD R6, R6, #-1			; R6 = x5FF4
STR R1, R6, #0

; int result
LDR R0, R5, #4			; R0 = int a = x + #10 = #20
ADD R6, R6, #-1			; R6 = x5FF3
STR R0, R6, #0

; check if b > a
LDR R1, R5, #3			; R1 = int b = y = #11

NOT R0, R0
ADD R0, R0, #1			; R0 = -a

ADD R0, R0, R1			; R0 = R0 + R1 = -a + b
BRnz SKIP_IF

STR R1, R5, #-3			; result = b

SKIP_IF
; returning int result
LDR R0, R5, #-3			; R0 = int result
STR R0, R5, #2			

; pop int result
ADD R6, R6, #1			; R6 = x5FF4

; pop save R1 (reload R1)
LDR R1, R6, #0
ADD R6, R6, #1			; R6 = x5FF5

; pop save R0 (reload R0)
LDR R0, R6, #0
ADD R6, R6, #1			; R6 = x5FF6

; pop previous frame pointer (reload R5)
LDR R5, R6, #0
ADD R6, R6, #1			; R6 = x5FF7

; pop max's return address (reload R7)
LDR R7, R6, #0
ADD R6, R6, #1			; R6 = x5FF8

RET

.END