.globl gameArray
.globl LookUpTable
.globl startIntroMusic
.globl musicLength
.globl musicDuration


.data   
    gameArray: .word -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99, -99 #Empty Array

        
    LookUpTable: 
        .word 1,2,-1,-1,-1,-1   # Neighbors of Index 0
        .word 0,3,4,2,-1,-1     # Neighbors of Index 1
        .word 0,1,4,5,-1,-1     # Neighbors of Index 2
        .word 1,4,6,7,-1,-1     # Neighbors of Index 3
        .word 1,2,3,5,7,8       # Neighbors of Index 4
        .word 2,4,8,9,-1,-1     # Neighbors of Index 5
        .word 3,7,10,11,-1,-1   # Neighbors of Index 6
        .word 6,3,4,8,11,12     # Neighbors of Index 7
        .word 7,4,5,9,12,13     # Neighbors of Index 8
        .word 8,5,13,14,-1,-1   # Neighbors of Index 9
        .word 6,11,15,16,-1,-1  # Neighbors of Index 10
        .word 6,7,10,12,16,17   # Neighbors of Index 11
        .word 7,8,11,13,17,18   # Neighbors of Index 12
        .word 8,9,12,14,18,19   # Neighbors of Index 13
        .word 9,13,19,20,-1,-1  # Neighbors of Index 14
        .word 10,16,-1,-1,-1,-1 # Neighbors of Index 15
        .word 10,11,15,17,-1,-1 # Neighbors of Index 16
        .word 11,12,16,18,-1,-1 # Neighbors of Index 17
        .word 12,13,17,19,-1,-1 # Neighbors of Index 18
        .word 13,14,18,20,-1,-1 # Neighbors of Index 19
        .word 14,19,-1,-1,-1,-1 # Neighbors of Index 20

    startIntroMusic: .word 60 ,60, 64, 64, 72       # Intro Music attributes
    musicLength: .word 5
    musicDuration: .word 450,520,520,520,1000

.text