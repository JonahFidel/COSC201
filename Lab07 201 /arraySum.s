# ArraySum
# 
# Takes the array in data memory from location 0 to n-1 and replaces
# it with the array of partial sums
# 

.data
A:	.word 0x3, 0xf, 0x14, 0x2

.text
.globl main

main:

	la $t4, A			# t4 is base address of array A

	addi $t1, $t4, 16		# set last value as 16 past base
	add $t0, $zero, $t4		# set k = base
	add $t2, $zero, $zero		# set sum = 0

loop: 	beq $t0, $t1, endprg		# branch to end of program
	lw $t3, 0($t0)			# t3 = A[k]
	add $t2, $t2, $t3		# sum = sum + A[k]
	sw $t2, 0($t0)			# A[k] = sum
	addi $t0, $t0, 4		# k = k+4
	j loop				# jump to top of loop
	
endprg:	beq $zero, $zero, endprg	# "stop" -- loop here forever
