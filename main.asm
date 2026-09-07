# CS2340 Term Project: Blackhole Game
#       
#       Author : Abdullah Naeem
#       Date: 04-03-2026
#       Location: UTD
#
.include "SysCalls.asm"  # SysCall file as per instructions

.data 
    computerPlaces: .asciiz "Computer Places at position: "
    newLine: .asciiz "\n"
.text 
Main: # Main

    la $t0, startIntroMusic         # Loads base address of notes array from board.asm
    lw $t1, musicLength             # Number of notes
    la $t3, musicDuration           # Duration for each note
    li $t2, 0                       # Music Loop index = 0

    IntroMusicLoop:
        beq $t2, $t1, EndIntroMusic

        lw $a0, 0($t0)              # Load the pitch from startIntroMusic array
        lw $a1, 0($t3)              # duration (300ms)
        li $a2, 0                   # Instrument: Piano
        li $a3, 100                 # load immediate Volume
        li $v0, SysMidiOutSync      # MIDI out synchronous
        syscall                     # run system call

        addi $t0, $t0, 4            # move onto the next note, by incrementing baseAddress by 4, because word = 4 bytes
        addi $t2, $t2, 1            # increment music Loop index by 1
        addi $t3, $t3, 4            # move onto next note Duration, increment by 4, word = 4 bytes
        
        j IntroMusicLoop            # Jump back to IntroMusicLoop
    EndIntroMusic: # End intro music and start the game

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard                  # Call DrawBoard procedure

    # Round 1
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 1                      # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -1                      # load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to Print String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 2
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load base Address of gameArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 2                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -2                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 3
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 3                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -3                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 4
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 4                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -4                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 5
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 5                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -5                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    #Round 6
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 6                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -6                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 7
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 7                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -7                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    #Round 8
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 8                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -8                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 9
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 9                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0             
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -9                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    # Round 10
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal InputValidation            # Call InputValidation Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, 10                       # Load player tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    
    la $a0, gameArray              # Load address of beginningArray into $a0
    jal ComputerInput              # Call ComputerInput Procedure

    add $t0, $v0, $zero            # saved returned value into $t0
    la $t1, gameArray              # Load address of gameArray into $t1
    sll $t2, $t0, 2                # offset = index * 4
    add $t1, $t1, $t2              # base address + offset
    li $t3, -10                      # Load computer tile value for current round
    sw $t3, 0($t1)                  # save player tile value into gamearray at chosen index

    la $a0, computerPlaces          # Load address of string computerPlaces into $a0
    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    addi $a0, $t0, 1                # add returned value plus 1 into $a0
    li $v0, SysPrintInt          # Service call to read String (SysCalls.asm)
    syscall                         # run system call

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    la $a0, gameArray              # Load address of beginningArray into $a0
    jal DrawBoard           # Call DrawBoard procedure

    li $v0, SysPrintString          # Service call to read String (SysCalls.asm)
    la $a0, newLine                # load address of string newLine to $a0
    syscall                         # run system call

    #Loop to find the non filled hole
    li $t5, 0                   # Initialize loop index to 0
    la $t6, gameArray           # Load gameArray address into $a0
    For:    # For loop
    bgt $t5, 20, Winner         # If index > 20, branch to Winner
    sll $t7, $t5, 2             # offset = index * 4
    add $t7, $t7, $t6           # offset + baseAddress
    lw $t8, 0($t7)              # load value of current hole into $t8
    If: # if value != -99
        bne $t8, -99, increment # if hole is not Empty (-99) branch to increment
        li $t9, 0               # Load 0 into $t9
        sw $t9, 0($t7)          # Load 0 into the empty hole position
        j Winner                # Jump to Winner Label
    increment:  # increment Loop index
        addi $t5, $t5, 1        # add 1 to loop index
        j For                   # Jump back to For Loop
    Winner: # Send completed gameArray into Scoring Procedure
        la $a0, gameArray              # Load address of beginningArray into $a0
        jal DrawBoard           # Call DrawBoard procedure
        
        la $a0, gameArray       # load base Address of gameArray into $a0
        jal ScoreGame           # Call ScoreGame procedure
    
    li $v0, SysExit                # Service call to exit (Syscalls.asm)
    syscall                         # run system call
