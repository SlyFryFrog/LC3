.ORIG x3000

LEA R0, PROMPT_MSG     ; Load the address of the prompt message into R0
TRAP x22               ; Print the prompt using the PUTS trap
HALT

PROMPT_MSG  .STRINGZ "Enter an array size (5-20): "

.END
