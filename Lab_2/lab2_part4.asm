.data
varA:   .word   0,0,0,0,0
varB:   .word   1,2,4,8,16
.text
main: 
    la  t6, varA       # Load A
    la  t5, varB        # Load B
    addi a0,zero,-1	
    addi s11,zero,4
    loop: 
    	slti t4,s0,5
    	beq t4,zero,false
    	slli t3,s0,2		#t3 = i*4
    	slli t2,s0,2		#t2 = i*4
    	add t3,t6,t3		#t3 -> a[i]
    	add t2,t5,t2		#t2 -> b[i]
    	lw t1, 0(t2)		#loads array of b into t1
    	addi t1, t1,-1		#subtracts one from value of array b
    	sw t1,0(t3)		#stores the values of t1 into t3 
    	addi s0,s0,1
    	j loop
    
    false:
    	addi s0,s0,-1
    	
    while:
    	beq s0, a0, else	#goes to -1 because need to run five times
	slli t3, s0, 2  	#t3 = i*4
	slli t2, s0, 2		#t2 = i*4
	add t3, t5, t3 		#t3 -> b[i]
	add t2, t6, t2 		#t2 -> a[i]
	lw s1, 0(t3)		#loads array of b into s1
	lw s2, 0(t2)		#loads array of b into s2
	add s3, s1, s2		#adds array a and array b
	addi s4, zero, 2
	mul s3, s3, s4
	sw s3, 0(t2)
	addi s0, s0, -1
    	j while
    else:
    
    li  a7,10       #system call for an exit
    ecall
    
    	
    	