		# MatMultDriver
		#
		# Sets up three 4x4 matrices of doubles in memory
		#
		# Calls MatMult
		#
		# results replace xmat in memory

.data

rowlen:	.word	8
xmat:	.word	1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3, 1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3
		1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3, 1, 1, 1, 1, 2, 2, 2, 2, -1, -1, -1, -1, 3, 3, 3, 3
ymat:	.word	2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1, 2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1
		2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1, 2, -1, 3, 2, 1, -2, 3, 5, 4, 6, -2, 3, 2, 3, 1, -1
zmat:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

newline:	.asciiz		"\n" 
space:		.asciiz		" "

.text
.globl main
.globl printMat
main:
		la $t0, rowlen
		lw $s0, 0($t0)

		la $a0, xmat
		addi $a1, $s0, 0
		jal printMat
		
		la $a0, ymat
		addi $a1, $s0, 0
		jal printMat
		
		la $a0, xmat
		la $a1, ymat
		la $a2, zmat
		addi $a3, $s0, 0

		jal MatMult

		la $a0, zmat
		addi $a1, $s0, 0
		jal printMat
		

return:
		li	$v0, 17		# Return value
		li	$a0, 0
		syscall			# Return
		
		
printMat:
		addi	$t0, $a0, 0	# $t0 = base address of array
		addi	$t1, $a1, 0	# $t1 = rowlen
		
		la	$a0, newline	# Load the address of the string 
	        li	$v0, 4		# Load the system call number
		syscall 

		sll $t2, $t1, 2  	# t2 is row length in bytes
		mul $t3, $t1, $t2	# t3 total bytes in array
		add $t4, $t0, $t2	# t4 terminates row
		add $t5, $t3, $t0	# t5 = address after end of array

colLoop:
		la	$a0, space	# Load the address of the string 
	        li	$v0, 4		# Load the system call number
		syscall 

		lw $a0, 0($t0)		# set $a0 to matrix entry
		addi $v0, $zero, 1
		syscall			# print matrix entry
		
		addi $t0, $t0, 4
		bne $t0, $t4, colLoop
		
					# Print newline 
		la	$a0, newline	# Load the address of the string 
	        li	$v0, 4		# Load the system call number
		syscall 

		add 	$t4, $t4, $t2
		bne	$t0, $t5, colLoop
		
		jr $ra
		
		
		
		
		











