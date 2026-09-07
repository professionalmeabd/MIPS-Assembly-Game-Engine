.globl ScoreGame

.include "SysCalls.asm"  # SysCall file as per instructions

.data
Msgs:   # Strings for WinnerLogic
    P1winsMsg: .asciiz "Player 1 wins with a score of: "
    CongratulateP1: .asciiz "Congratulations! You win! "
    P1Loses: .asciiz "Computer Wins. Better Luck Next Time! "

    P2winsMsg: .asciiz "Computer wins with a score of: "

    TieMsg: .asciiz "Both Players tied at: "
    # Strings for PrintLoop and EndPrint
    space: .asciiz " "

    newLine: .asciiz "\n"


.text
ScoreGame:  # Proc name
    addi $sp, $sp, -24          # Allocate 24 bytes of storage to the stack for five saved registers
    sw $ra, 20($sp)             # Push $ra to stack
    sw $s4, 16($sp)             # Push $s4 to stack
    sw $s3, 12($sp)             # Push $s3 to stack
    sw $s2, 8($sp)              # Push $s2 to stack
    sw $s1, 4($sp)              # Push $s1 to stack
    sw $s0, 0($sp)              # Push $s0 to stack

    la $s3, gameArray           # Load baseAdress of gameArray in $s3
    la $t3, LookUpTable         # Load baseAdress of LookUpTable into $t3

InitializeVariables: # Initialize variables
    li $s0, 0               # initialize indexBlackhole to 0
    li $s1, 0               # initlialize P1Score to 0
    li $s2, 0               # initlialize P2Score to 0
    li $s4, 0               # initialize table to 0

ForOuter:   # Outer For Loop
    bge $s0, 21, WinnerLogic    # If indexBlackhole >= 21, exit blackhole search
    sll $t0, $s0, 2         # Get offset = indexBlackhole * 4, sll just does 2^2
    add $t1, $s3, $t0       # add baseArray + offset
    lw $t1, 0($t1)          # temp = mem[Base + offset]

    beq $t1, $zero, ElseBlackhole   # if array[index] = 0, found blackhole, branch to ElseBlackHole

IfBlackhole: # Fall through logic for If array[index] != 0
    j OuterLoopIncrement    # Jump to OuterLoopIncrement

ElseBlackhole:  # if temp == 0
    mul $t4, $s0, 24    # Set rowOffset, indexBlackhole * 24
    add $s4, $t3, $t4   # add Lookuptable address + rowOffset = table
    li $t6, 0           # Initialize neighborIndex to 0

    ForInner: # Inner For Loop
        bge $t6, 6, OuterLoopIncrement  # If neighbor index >= 6, branch to OuterLoopIncrement
        sll $t5, $t6, 2                 # innerOffset = neighborIndex * 4
        add $t9, $s4, $t5               # add table + innerOffset
        lw $t9, 0($t9)                  # $t9 = mem[table + innerOffset]
        add $t1, $t9, $zero             # temp2 = $t9

    IfNeighbor: # Fall through logic, If temp2 == -1
        li $t2, -1                      # Stop condition for look up table = -1
        beq $t1, $t2, NeighborIncrement # if temp2 == -1, branch to NeighborIncrement

    ElseNeighbor: # If temp2 != -1
        sll $t7, $t1, 2                 # ArrayOffset = temp2 * 4
        add $t8, $s3, $t7               # add Base array address + ArrayOffset
        lw $t8, 0($t8)                  # Points = mem[Base + ArrayOffset]
        li $t9, -99                     # Loads the designated sentinel value -99(indicates empty hole)
        beq $t8, $t9, NeighborIncrement # If hole is Empty, skip scoring and branch to NeighborIncrement
        blt $t8, $zero, ElsePoints      # if points < 0, branch to ElsePoints

        IfPoints: # Fall through logic, if points > 0
            add $s1, $s1, $t8           # P1Score += points
            j NeighborIncrement         # jump to NeighborIncrement

        ElsePoints: # if points < 0
            sub $s2, $s2, $t8           # P2Score -= points

    NeighborIncrement:  # Increments Neighborindex by 1
        addi $t6, $t6, 1    # Neighborindex++
        j ForInner          # jump to ForInner loop


OuterLoopIncrement: # Increments indexBlackhole by 1
    addi $s0, $s0, 1    # indexBlackhole++
    j ForOuter          # jump to ForOuter loop

WinnerLogic: # Logic to decide winner
    beq $s1, $s2, Tie       # If P1score = P2Score, jump to Tie logic   
    blt $s2, $s1, P2wins    # if P2Score < P1Score, jump to P2Wins logic

    P1Wins: # Fall through logic if P1Score < P2Score
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, P1winsMsg              # load address of string P1winsMsg to $a0
    syscall                         # run system call

    li $v0, SysPrintInt             # Service call to read String (SysCalls.asm)
    add $a0, $s1, 0                 # Place Value of P1Score in $a0
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    li $a0, 72              # Note 1 pitch
    li $a1, 500             # Duration (500 ms)
    li $a2, 0               # Instrument: Piano
    li $a3, 100             # Volume 
    li $v0, SysMidiOutSync  # MIDI out synchronous
    syscall                 # run system call

    li $a1, 900             # Duration (900ms)
    li $a0, 84              # Note 2 pitch
    li $v0, SysMidiOutSync  # MIDI out synchronous
    syscall                 # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, CongratulateP1          # load address of string CongratulateP1 to $a0
    syscall                         # run system call

    j restoreStack                  # jump to restoreStack

    P2wins: # If P2Score < P1Score
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, P2winsMsg               # load address of string P2winsMsg to $a0
    syscall                         # run system call

    li $v0, SysPrintInt             # Service call to read String (SysCalls.asm)
    add $a0, $s2, 0                 # Place Value of P2Score in $a0
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    li $a0, 50              # Note 1 Pitch
    li $a1, 500             # Duration (500 ms)
    li $a2, 0               # Instrument: Piano
    li $a3, 100             # Volume 
    li $v0, SysMidiOutSync  # MIDI out synchronous
    syscall                 # run system call

    li $a1, 900             # Duration (900ms)
    li $a0, 43              # Note 2 
    li $v0, SysMidiOutSync  # MIDI out synchronous
    syscall                 # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, P1Loses                 # load address of string P1Loses to $a0
    syscall                         # run system call

    j restoreStack                  # Jump to restoreStack
       
    Tie: # if P1 Score == P2 Score
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, TieMsg                 # load address of string TieMsg to $a0
    syscall                         # run system call

    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    add $a0, $s1, 0                # Place Value of P1Score(equal to P2Score in this case) in $a0
    syscall                         # run system call

    j restoreStack                 # jump to restoreStack

restoreStack:   
    lw $s0, 0($sp)          # Pop $s0 from stack
    lw $s1, 4($sp)          # Pop $s1 from stack
    lw $s2, 8($sp)          # Pop $s2 from stack
    lw $s3, 12($sp)         # Pop $s3 from stack
    lw $s4, 16($sp)         # Pop $s4 from stack
    lw $ra, 20($sp)         # Pop $ra from stack
    addi $sp, $sp, 24       # deallocate the 24 bytes to restore stack

    jr $ra                  # Return to caller

