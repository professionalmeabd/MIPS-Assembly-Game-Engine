.include "SysCalls.asm"  # SysCall file as per instructions
.globl ComputerInput

.data 

.text 
ComputerInput: # Proc name
    addi $sp, $sp, -12          # Allocate 12 bytes on stack for three saved registers
    sw $s2, 8($sp)              # Push $s2 to stack
    sw $s1, 4($sp)              # Push $s1 to stack
    sw $s0, 0($sp)              # Push $s0 to stack

    la $s1, gameArray           # Load base address of gameArray into $s1 

While:  # While true              
    li $v0, SysRandIntRange     # Service call to get random integer within specified range (SysCalls.asm)
    li $a0, 0                   # Set $a0 to 0
    li $a1, 21                  # Set upper bound to 21, range (0-20)
    syscall                     # run system call
    add $s0, $a0, $zero         # Save random index to $s0

    sll $t1, $s0, 2             # Offset = random index * 4
    add $t1, $t1, $s1           # baseAdress + offset
    lw $s2, 0($t1)              # value = array[$t1] into $s2
        
    li $t2, -99                 # Load immediate sentinel value -99
    bne $s2, $t2, isNotEmpty    # if value != -99, branch to isNotEmpty
    add $v0, $s0, $zero         # Slot empty, set return value to randomIndex

    j restoreStack              # jump to restoreStack

    isNotEmpty: # if value == -99
        j While                 # jump back to While Loop

restoreStack: # restores stack
    lw $s0, 0($sp)              # Pop $s0 from stack
    lw $s1, 4($sp)              # Pop $s1 from stack
    lw $s2, 8($sp)              # Pop $s2 from stack
    addi $sp, $sp, 12           # deallocate 12 bytes to restore Stack

    jr $ra                      # return to caller

