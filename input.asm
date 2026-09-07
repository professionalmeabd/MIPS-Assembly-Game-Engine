.globl InputValidation
.include "SysCalls.asm"
.data
    errorOutOfRange: .asciiz "Error: Out of range, Retry \n"
    errorHoleNotEmpty: .asciiz "Error: Spot is full, Retry \n"
    userPrompt: .asciiz "Enter hole position 1-21:  "
        
.text
InputValidation: # Input validation proc
    addi $sp, $sp, -16          # Allocate 16 bytes to stack for 4 saved registers
    sw $s3, 12($sp)             # Push $s3 to stack
    sw $s2, 8($sp)              # Push $s2 to stack
    sw $s1, 4($sp)              # Push $s1 to stack
    sw $s0, 0($sp)              # Push $s0 to stack

    la $s2, gameArray           # Load Base address for gameArray into $s2

While: # While true
    li $v0, SysPrintString      # Service call to print string
    la $a0, userPrompt          # Load address of string userPrompt to $a0
    syscall                     # Run system call

    li $v0, SysReadInt          # Service Call to read integer input from player
    syscall                     # Run system call

    add $s0, $v0, $zero         # Save userInput into register $s0
    addi $s1, $s0, -1           # indexedInput = userInput - 1

    blt $s1, $zero, outOfRange  # If indexedInput < 0, branch to outOfRange
    li $t0, 20                  # Load the max value for indexedInput = 20
    bgt $s1, $t0, outOfRange    # If indexedInput > 20, branch to outOfRange

    sll $t1, $s1, 2             # offset = indexedInput * 4
    add $t1, $t1, $s2           # baseAddress + offset
    lw $s3, 0($t1)              # value = mem[baseAddress + offset]

    li $t2, -99                 # Load the sentinel value -99 into $t2
    bne $s3, $t2, notEmpty      # If value != -99, branch to notEmpty
    add $v0, $s1, $zero         # Set return value to indexedInput

    j restoreStack              # Jump to restoreStack
    outOfRange: # if userInput out of range
    li $v0, SysPrintString      # Service call to print string
    la $a0, errorOutOfRange     # Load address of string errorOutOfRange to $a0
    syscall                     # Run system call
    
    j While                     # Jump back to the while loop
    notEmpty:   # if hole not empty
    li $v0, SysPrintString      # Service call to print string
    la $a0, errorHoleNotEmpty   # Load address of string errorHoleNotEmpty to $a0
    syscall                     # Run system call

    j While                     # Jump back to the while loop
restoreStack: # restore Stack and return
    lw $s0, 0($sp)              # Pop $s0 from stack
    lw $s1, 4($sp)              # Pop $s1 from stack
    lw $s2, 8($sp)              # Pop $s2 from stack
    lw $s3, 12($sp)             # Pop $s3 from stack
    addi $sp, $sp, 16           # Deallocate 16 bytes to restore Stack

    jr $ra                      # Return to caller
