.data
varA:   .word   0
varB:   .word   0
varC:   .word   0
.text

main:
    addi t0,zero,5		#i=5
    addi t1,zero,10		#j=10
    
    addi sp,sp, -8		#allocate space for 8 bits for the additup function
    sw t0,4(sp)			
    sw t1,0(sp)
    
    add s0,zero,t0		#sets "n" as t0
    jal additup			#jumps to additup
    sw t1, varA,s0		#stores the word of t0 
    
    lw t1, 0(sp)		#loads t1 into the stack from additup
    add s0,zero,t1		#sets "n" as t1
    jal additup
    sw t1, varB, s0		#stores the word of t1
    
    addi sp,sp,8		#restores the stack 
    
    lw t0, varA			
    lw t1, varB
    add t2,t0,t1
    sw t2, varC, s0
    
    li a7,10 
    ecall

additup:
    add t0,zero,zero		#int i = 0;
    add t1,zero,zero		#int x = 0
    
    loop:
    	slt a1,t0,s0
    	beq a1,zero,exit
    	addi a2,t0,1		#add i + 1
    	add t1,t1,a2		#adds x +(i + 1)
    	addi t0,t0,1		#i++
    	j loop
    exit:
    	ret


    	
 
