.ORIG x3000

WHILE_TRUE
LEA R0, NL
PUTS

LEA R0, PROMPT
PUTS

GETC
OUT

LD R1, N_ASCII
ADD R1, R0, R1  ; R1 = GETC - 48
NOT R1, R1
ADD R1, R1, #1  ; R1 = -R1

LEA R0, NL
PUTS

LD R0, NUM
ADD R0, R0, R1

BRz EQUAL
BRp LESS
BRn GREATER

EQUAL
    LEA R0, EQUAL_TO
    PUTS

    BRnzp RETURN

LESS
    LEA R0, LESS_THAN
    PUTS

    BRnzp RETURN

GREATER
    LEA R0, GREATER_THAN
    PUTS

    BRnzp RETURN

RETURN
    LD R0, NUM
    LD R1, ASCII
    ADD R0, R0, R1
    OUT

    BRnzp WHILE_TRUE


ASCII .FILL #48
N_ASCII .FILL #-48
NUM .FILL #5

PROMPT .STRINGZ "Please enter a number: "
NL .STRINGZ "\n"

LESS_THAN .STRINGZ "The number you entered was less than "
EQUAL_TO .STRINGZ "The number you entered was equal to "
GREATER_THAN .STRINGZ "The number you entered was greater than "
.END