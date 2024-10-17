.ORIG x3000

START
    LEA R0, NEWLINE
    PUTS
    
    LEA R0, PROMPT
    PUTS

    GETC
    OUT

    LD R1, ASCII_OFFSET
    ADD R1, R1, R0

    BRn LESS
    BRz EQUAL
    BRp GREATER


    LESS
        LEA R0, NEWLINE
        PUTS

        LEA R0, LESS_THAN_7
        PUTS
        BRnzp START

    EQUAL
        LEA R0, NEWLINE
        PUTS

        LEA R0, EQUAL_TO_7
        PUTS
        BRnzp START
    
    GREATER
        LEA R0, NEWLINE
        PUTS
        
        LEA R0, GREATER_THAN_7
        PUTS
        BRnzp START

    LEA R0, NEWLINE
    PUTS

    BRnzp START

PROMPT .STRINGZ "Please enter a number: "
NEWLINE .STRINGZ "\n"
LESS_THAN_7 .STRINGZ "The number you entered was less than 7!"
EQUAL_TO_7 .STRINGZ "The number you entered was equal to 7!" 
GREATER_THAN_7 .STRINGZ "The number you entered was greater than 7!"

ASCII_OFFSET .FILL #-55

.END