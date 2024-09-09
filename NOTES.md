# ADD

`0001 = ADD`

0000 		- First four bits indicate instruction
0000 0000 0000 	- Next twelve bits indicate procedure

### Two possible formats for ADD

```
0001 DR SR1 0 00 SR2

0001 XXX XXX XXX XXX
```
```
0001 DR SR1 1 IMM5

0001	XXX	XXX	XXXXX
ADD	DR	SR1	IMM5
```

DR 	- Destination register
SR1	- First source register
SR2	- Second source register 
IMMS	- 5-bit signed register

```
0001	010	101	000	110
ADD	DR1	SR2		SR3
```


# AND

Performs bitwise AND on two numbers

`0101 = AND`

```
0101 DR SR1 0 00 SR2
```
```
0101 DR SR1 1 IMM5

0101 001 001 1 00000
->
AND R1, R1, #0
->
0000 0000 0000 0000
```

# NOT

`1001 = NOT`

```
1001 DR SR1 1 11 111

1001 011 011 1 11 11

R3 = 0000 0000 1001 1101
->
R3 = 1111 1111 0110 0010 
``` 

# Data Movement Instructions

- Store = Register to Memory
- Load = Memory to Register

```
XXXX XXX XXXXXXXXX
```

## Load

`PCoffset9 = DesiredLocation - InstructionLocation - 1;`

```
LD R0, x300A
->
PCoffset9 = x300A - x3005 -1;
= x000A - x0005 -1;
= x0005 -1;
= x0004;
->
0010 000 000000100 
```
