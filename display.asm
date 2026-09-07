.globl DrawBoard

.include "SysCalls.asm"  # SysCall file as per instructions

.data 
    emptyHoleString: .asciiz "( )"  # Strings for the board itself
    blackHoleString: .asciiz "(B)"
    leftParenthesis: .asciiz "("
    rightParenthesis: .asciiz ")"
    space: .asciiz " "
    newLine: .asciiz "\n"

.text 


DrawBoard:  # DrawBoard Procedure
    addi $sp, $sp, -12          # Allocate 12 bytes of storage to the stack for three saved registers
    sw $s2, 8($sp)              # Push $s2 to stack
    sw $s1, 4($sp)              # Push $s1 to stack
    sw $s0, 0($sp)              # Push $s0 to stack

    li $s0, 1                   # initilialize row counter to 1
    li $s1, 0                   # intilialize arrayIndex to 0
    add $s2, $a0, $zero         # Copy the incoming array address to $s2
WhileLoop:  # While (row <= 6)
    li $t5, 6                   # load row limit constant = 6 into temp register
    bgt $s0, $t5, restoreStack  # if row > 6, branch to restoreStack

    li $t0, 6                   # load immediate 6 into temp register
    sub $t0, $t0, $s0           # calculate 6 - row and put it in $t0
    sll $t0, $t0, 1             # calculate (6-row)*2 and put these into spaces variable

    li $t1, 0                   # Initialize SpaceNo to 0

    ForSpace:   # For (spaceNo = 0; spaceNo < spaces; spaceNo++)
        bge $t1, $t0, InitlializeForHole    # if spaceNo >= spaces, branch to InitializeForHole

        li $v0, SysPrintString          # Service call to print String
        la $a0, space           # load address of string space to $a0
        syscall                         # run system call

        addi $t1, $t1, 1        # Incremenet SpaceNo by 1

        j ForSpace              # Jump to ForSpace

    InitlializeForHole: # Initialize the hole variable
        li $t2, 1               # Initialize hole variable to 1
    ForHole: # for(hole = 1; hole <= row; hole++)
        bgt $t2, $s0, WhileIncrement    # if hole > row, branch to WhileIncrement
        sll $t3, $s1, 2                 # Offset = arrayIndex * 2^2

        add $t4, $s2, $t3               # add Base + offset
        lw $t4, 0($t4)                  # value = mem[Base + offset]

        if: #if (value == -99)
            li $t7, -99                 # Load sentinel value -99 into $t7
            bne $t4, $t7, elseIf        # if value != -99, branch to elseIf

            li $v0, SysPrintString          # Service call to print String
            la $a0, emptyHoleString     # load address of emptyHoleString space to $a0
            syscall                         # run system call

            j ForHoleIncrement          # Jump to ForHoleIncrement
        elseIf: #else if (value == 0)
            bne $t4, $zero, else        # if value != 0, branch to else

            li $v0, SysPrintString          # Service call to print String
            la $a0, blackHoleString     # load address of string blackHoleString to $a0
            syscall                         # run system call

            j ForHoleIncrement          # Jump to ForHoleIncrement
        else: #else (when value != 0 && value != -99)
            li $v0, SysPrintString          # Service call to print String
            la $a0, leftParenthesis     # load address of string leftParenthesis to $a0
            syscall                         # run system call

            li $v0, SysPrintInt          # Service call to print Integer
            add $a0, $t4, 0             # Place value into $a0
            syscall                         # run system call

            li $v0, SysPrintString          # Service call to print String
            la $a0, rightParenthesis    # load address of string rightParenthesis to $a0
            syscall                         # run system call

    ForHoleIncrement: # Increment the ForHoleLoop 

        li $v0, SysPrintString          # Service call to print String
        la $a0, space           # load address of string space to $a0
        syscall                         # run system call

        addi $t2, $t2, 1        # Increment hole by 1
        addi $s1, $s1, 1        # Increment arrayIndex by 1

        j ForHole               # Jump to ForHole

        
WhileIncrement: # Increment the While loop
    li $v0, SysPrintString          # Service call to print String
    la $a0, newLine         # load address of string newLine to $a0
    syscall                         # run system call

    addi $s0, $s0, 1        # Increment row by 1
    j WhileLoop             # Jump to WhileLoop

restoreStack:   # restore the stack
    lw $s0, 0($sp)          # Pop $s0 from stack
    lw $s1, 4($sp)          # Pop $s1 from stack
    lw $s2, 8($sp)          # Pop $s2 from stack
    addi $sp, $sp, 12       # deallocate the 12 bytes to restore stack

    jr $ra                  # Return to caller