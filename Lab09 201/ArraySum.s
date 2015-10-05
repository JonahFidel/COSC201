# Arraysum.s
# Compute the sum of the elements in an array.

# Student:	Your Name		Date

#	main()
#	{
#	    int k = len;
#	    do
#	    {
#	        k--;
#	        C[k] = A[k] + B[k];
#	    } while (k > 0);
#	}

# Preconditions:	
#
#   Length: length of array
#   arrayA: start of array A of integers
#           Arrays B and C follow immediately in memory with same length
# Postconditions:	
#   result array C is A + B, element-by-element
#
# Code uses pointer hopping

.text
.globl main

	main:
##########################################################
        # Note: pseudo-instruction la becomes lui followed by ori
	la 	$t0, length		# t0 = address of word before array[0], length
	lw	$t2, 0($t0)		# t2 = length
	sll	$t2, $t2, 2		# multiply length by 4 to make t2 = length in bytes
	add	$t1, $t2, $t0		# t1 is initial value for k, address of A[k-1], since base is at t0 + 4
	j	test			# jump to test at end of loop

loop:	lw	$t3, 0($t1)		# t2 = A[k]
	add	$t4, $t1, $t2		# t4 = address of B[k]
	lw	$t5, 0($t4)		# t5 = B[k]
	add	$t5, $t5, $t3		# t5 = A[k] + B[k]
	add	$t4, $t4, $t2		# t4 = address of C[k]
	sw	$t5, 0($t4)		# C[k] = A[k] + B[k]
	addi	$t1, $t1, -4		# k--
test:	
	bne	$t1, $t0, loop		# loop test
	
################################################################
	li	$v0, 17			# set codes for end syscall
	li	$a0, 0
	syscall				# end program

.data
length:	.word	8
arrayA:	.word	9, -8, 7, -2, 5, 4, -1, 2
arrayB:	.word	-8, 10, -4, 6, 0, 2, 8, 6
arrayC:	.word	0, 0, 0, 0, 0, 0, 0, 0

# 2009/11/08 
# Author: Chris Nevison
