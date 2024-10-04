# Runtime Stack

## Overview

- Uses Last In First Out (LIFO)
    - Operations
        - Push (adds item to stack)
        - Pop (removes item from stack)
    - Errors
        - Stack Underflow - trying to pop from an empty stack
        - Stack Overflow - trying to push to a full stack
- The Runtime Stack allows gives us a place to store our
variables
    - There are two components of the runtime stack:
        - Stack Pointer
            - Use R6 for this
            - Keeps track of the TOP of our stack
        - Frame Pointer
            - Use R5 for this
            - Keeps track of the BOTTOM of the current frame


## Definitions

- Global Variable Pointer - The global variable pointer always points to the top of your global variables section that follows the last instruction in your main section of instructions.

- Frame Pointer - The frame pointer always points to the BOTTOM of your stack for a current frame
    - The “bottom” is where your local variables start

- Stack Pointer - The stack pointer always points to the TOP of your stack
    - Below this area in memory you store (in this order):
        - Inputs to called function (if any)
        - Local variables
        - Saved Registers
        - Return Address
        - Return Values
    - When you enter into a new function/subroutine, you will move your stack pointer to the top of this new area

# LC3

## Overview

- .ORIG x3000 - Starting line of asm file
- .END - Ending line of asm file

## Subroutines

 - JSR - Jump to subroutine
 - RET - Return

