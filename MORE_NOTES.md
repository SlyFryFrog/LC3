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


Preprocessing: The C code is first passed through a preprocessor, which handles directives like #include and #define. This step modifies the code by including headers and expanding macros.

Compilation: The preprocessed code is then translated into assembly language by the compiler. This assembly code is specific to the target machine architecture.

Assembly: The assembly code is converted into object code, which consists of machine language instructions. This is done by an assembler. Object code is still not a complete program, as it might have unresolved references (like function calls to libraries).

Linking: The linker combines the object code with any required libraries or external functions to produce a final executable. This executable file contains all the machine language instructions needed for the program to run on the target system.

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
    - using 11 bits => label can be within +1024 / -1023 lines of JSR instruction
 - RET - Return
 
 ## IO

I/O Interface

- Through a set of Device Registers:
    - Status register (device is busy/idle/error)
        - KBSR: keyboard status register
        - DSR: display status register
    - Data register (data to be moved to/from device)
        - KBDR: keyboard data register
        - DDR: display data register
- The device registers have to be read/written by the CPU.

Polling (handshake synchronization)
- CPU checks the KBD Ready status bit
- If set, CPU reads the data register and resets the Ready bit
- Repeat
- Makes CPU-I/O interaction seem to be 

Polling: CPU in charge
- CPU checks the ready bit of status register (as per program
instructions).
    - If (KBSR[15] == 1) then load KBDR[7:0] to a register.
- If the I/O device is very slow, CPU is kept busy waiting.

### IO Devices
Keyboard
- When key is struck
    - ASCII code of character is written to KBDR[7:0] (least significant byte of data register)
    - KBSR[15] (Ready Bit) is set to 1.
    - Keyboard is locked until CPU reads KBDR.
    - The CPU sees Ready Bit, reads KBDR, and clears the Ready Bit, unlocking the keyboard.
Monitor
- When CPU is ready to output a character
    - CPU checks DSR[15] (Ready Bit) until it is set to 1
    - CPU writes character to DDR[7:0]
    - Monitor sets DSR[15] to 0 while it is busy displaying the character, then sets it back to 1 to indicate readiness for next character.
