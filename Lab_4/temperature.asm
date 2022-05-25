.data 
enter: .asciz "Enter Fahrenhiet: "
fahrenheit: .float  100.0
thirty: .float 32.0
five: .float 5.0
nine: .float 9.0
hundred: .float 273.15
printCel: .asciz "Celcius: "
printKel: .asciz "Kelvin: "
newln: .asciz "r\n"

.text 
main:
	li a7,4
	la a0, enter
	ecall
	li a7,6
	ecall
	fmv.s f0,fa0
	
	flw f1, thirty, t0
	flw f2, five, t0
	flw f3, nine, t0
	flw f9, hundred, t0
	
	jal celsius
	jal kelvin
	
	j exit

celsius:
	fsub.s f6, f0, f1	#fahrenhiet -32
	fdiv.s f7, f2,f3	# 5/9
	fmul.s f10,f6,f7		# gives celsius
	ret
	
kelvin:
	fadd.s f11, f10, f9
	ret
	
exit: 
	li a7, 4
	la a0, printCel
	ecall
	li a7,2
	ecall
	
	li a7,4
	la a0,newln
	ecall
	
	li a7,4
	la a0,printKel
	ecall
	
	fmv.s fa0,fa1
	li a7,2
	ecall	

	
	
