.ORIG x3000

WHILE_TRUE

LEA R0, STR_0
PUTS

GETC
OUT


; A
LD R1, A
ADD R1, R0, R1
BRz IS_VOWEL

; E
LD R1, E
ADD R1, R0, R1
BRz IS_VOWEL

; I
LD R1, I
ADD R1, R0, R1
BRz IS_VOWEL

; O
LD R1, O
ADD R1, R0, R1
BRz IS_VOWEL

; U
LD R1, U
ADD R1, R0, R1
BRz IS_VOWEL
BRnzp IS_CONS

IS_VOWEL

LEA R0, STR_1
PUTS

BRnzp WHILE_TRUE

IS_CONS

LEA R0, STR_2
PUTS

BRnzp WHILE_TRUE


HALT

STR_0 .STRINGZ "Please enter a letter: "
STR_1 .STRINGZ "\nThe letter you entered was a vowel!\n"
STR_2 .STRINGZ "\nThe letter you entered was a consonant!\n"

A .FILL #-97
E .FILL #-101
I .FILL #-105
O .FILL #-111
U .FILL #-117

.END