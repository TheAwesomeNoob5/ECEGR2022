.data
.text

main:
	
	addi t2,zero,20		#n is equal to 10
	jal Fib			#jumps to fibonacci
	add t0, zero, a0
	
	li a7,10
	ecall
	
Fib:
	addi t6,zero,1		#holds the value of 1 for else if
	bge zero, t2, if	#if (n <= 0)
	beq t2, t6, elseif	#else if (n == 1) 
	
	addi sp,sp,-8		#allocate space for 8 bits for Fibonacci(n-1) 
	sw ra, 0(sp)
	sw t2, 4(sp)
	
	addi t2,t2,-1		#n-1
	
	jal Fib			#goes back to fib till n goes back to zero
	
	add a1, zero, a0	#saves the second biggest value to a1
	
	lw ra, 0(sp)		
	lw t2, 4(sp)
	addi sp,sp,8		#restores the stack

	addi sp,sp,-12		#allocate space for 12 bits for Fibonacci(n-2) 
	sw ra, 0(sp)
	sw t2, 4(sp)
	sw a1, 8(sp)
	
	addi t2,t2,-2		#n-2
	
	jal Fib			#goes back to fib till n goes back to zero
	
	add a2,zero,a0		#saves the third biggest value to a2
	
	lw ra, 0(sp)
	lw t2, 4(sp)
	lw a1, 8(sp)
	addi sp,sp,12		#restores the stack
	
	add a0,a1,a2		#add the third biggest value and the second biggest value
	
	ret			#return

if:
	add a0,zero,zero	#set a0 as zero
	ret
elseif:
	addi a0,zero,1		#set a1 as 1
	ret