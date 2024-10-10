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

### C

- Preprocessor
    - macro substitution
        - conditional compilation
        - “source-level” transformations
    - output is still C
- Compiler
    - generates object file
    - machine instructions
- Linker
    - combine object files (including libraries)
    - into executable image

- Source Code Analysis
    - “front end”
    - parses programs to identify its pieces
        - variables, expressions, statements, functions, etc.
    - depends on language (not on target machine)
- Code Generation
    - “back end”
    - generates machine code from analyzed source
    - may optimize machine code to make it run more efficiently
    - very dependent on target machine
- Symbol Table
    - map between symbolic names and items
    - like assembler, but more kinds of information
    - stores information like names and scopes of variables and functions, objects, classes, etc.

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

    - Traps use a vector table
# LC3

## Overview

- .ORIG x3000 - Starting line of asm file
- .END - Ending line of asm file

## Subroutines

 - JSR - Jump to subroutine
 - RET - Return
 

