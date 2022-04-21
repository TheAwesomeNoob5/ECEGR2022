.data
varA:   .word   15
varB:   .word   10
varC:   .word   5
varD:   .word   2
varE:   .word   18
varF:   .word   -3
varZ:   .word   0
    .text

main:       # Start of code section

    # Read variables from memory to registers (option 1)
    la  t0, varA        # Load A
    lw  t6, 0(t0)

    la  t0, varB        # Load B
    lw  t5, 0(t0)

    la  t0, varC        # Load C
    lw  t4, 0(t0)

    la  t0, varD        # Load D
    lw  t3, 0(t0)
    
    la  t0, varE        # Load E
    lw  t2, 0(t0)

    la  t0, varF        # Load F
    lw  t1, 0(t0)
    
    la t0, varZ
    lw s11, 0(t0)
    
    sub s0,t6,t5
    mul s1,t4,t3
    sub s2,t2,t1
    div s3,t6,t4
    
    add s11,s0,s1
    add s11,s11,s2
    sub s11,s11,s3
    
    sw s11, varZ,a0
    li  a7,10       #system call for an exit
    ecall
