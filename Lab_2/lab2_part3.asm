.data
varZ:   .word   2
varI:   .word   
.text
main: 
    la  t0, varZ       
    lw  t6, 0(t0)

    la  t0, varI        
    lw  t5, 0(t0)
    
    addi s0,zero,20
    addi s1,zero,1
    
    loop: 
    	slt t4,s0,t5
    	bne t4,zero,useless1
    	addi t5,t5,2
    	addi t6,t6,1
    	j loop
    
    useless1:
    
    do:
    	addi t6,t6,1
    	slti t3,t6,100
    	beq t3,zero,useless2
    	j do
    	
    useless2:
    
    while:
   	slt t2,zero,t5
   	beq t2,zero,exit
   	addi t6,t6,-1
   	addi t5,t5,-1
   	j while
    
    exit:
    	sw t6, varZ, a0
    
    li  a7,10       #system call for an exit
    ecall
