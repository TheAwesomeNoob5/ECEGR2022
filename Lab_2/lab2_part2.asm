.data
varA:   .word   15
varB:   .word   15
varC:   .word   10
varZ:   .word   0
    .text

main: 
    la  t0, varA        # Load A
    lw  t6, 0(t0)

    la  t0, varB        # Load B
    lw  t5, 0(t0)

    la  t0, varC        # Load C
    lw  t4, 0(t0)

    la  t0, varZ        # Load Z
    lw  t3, 0(t0)
    
    addi s0,zero,5	#5
 
    slt t2,t6,t5 	#A < B
    slt t1,s0,t4 	#C > 5
    and s1,t1,t2	#(A < B && C > 5)
    
    addi s11, t4, 1	#(C+1)
    addi s10, zero, 7	#7
    slt s2,t5,t6	#B < A
    beq s10,s11,true	#(C+1) == 7
    
    beq s1,zero,elseif
    addi t3,zero,1
    
    true: 
    	addi s3,zero,1	#if (C+1) == 7 then the value is zero
    	j elseif
    	
    elseif: 
    	or s4,s3,s2 
    	beq s4,zero,setas3
    	addi t3,zero,2
    	j exit
    	
    setas3: 
    	addi t3,zero,3
    	j exit
    	
    exit:
    	addi a0,zero, 1
    	addi a1,zero, 2
    	addi a2,zero, 3
    	
    	beq t3, a0, case1
    	beq t3, a1, case2
    	beq t3, a2, case3
    	addi t3,zero,0
    	j store
    case1: 
    	addi t3,zero,-1
    	j store
    case2: 
    	addi t3,zero,-2
    	j store
    case3: 
    	addi t3,zero,-3
    	j store
    store: sw t3,  varZ, t0

    li  a7,10       #system call for an exit
    ecall
    	   

    
    
