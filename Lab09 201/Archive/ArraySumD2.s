# ArraysumD2.s
# Compute the sum of the elements in an array.

# Student: Jonah Fidel       12/12/14

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
	#la 	$t0, length		             		# t0 = address of word before array[0], length
	addi	$t0, $zero, 0		lw    $t2, 0($t0)	# t2 = length
	nop
	
	sll	$t2, $t2, 2					# multiply length by 4 to make t2 = length in bytes
	add	$t1, $t2, $t0				# t1 is initial value for k, address of
	add	$t4, $t1, $t2				# t4 =  B[k]
	addi	$t0, $t0, 4		
	j	test						# jump to test at end of loop
	
	loop:					
					lw	$t3, 0($t1)	# t2 = A[k]
					lw	$t5, 0($t4)	# t5 = B[k]
	
	add	$t5, $t5, $t3		lw     $t6, 4($t1) 	# t5 = A[k] + B[k]
	add	$t4, $t4, $t2		sw     $t5, 0($t4)	# t4 = address of C[k]
                                                # C[k] = A[k] + B[k]
	add	$t4, $t1, $t2		lw     $t5, 4($t4)
	add	$t5, $t5, $t6		lw     $t3, 8($t1)
	add	$t4, $t4, $t2		sw     $t5, 4($t4)
	add     $t4, $t1, $t2		lw     $t5, 8($t4)
	add     $t5, $t5, $t3        	lw     $t6, 12($t1)    
	add     $t4, $t4, $t2           sw     $t5, 8($t4)        
        add     $t7, $t1, $t2           lw     $t8, 12($t7)      
        add     $t8, $t8, $t6    	            
        add     $t7, $t7, $t2           sw     $t8, 12($t7)                
	addi	$t1, $t1, -16		
test:	
	bne	$t1, $t0, loop					# loop test
	add	$t4, $t1, $t2
################################################################
	li	$v0, 17						# set codes for end syscall
	li	$a0, 0
	syscall							# end program

.data
length:	.word	8
arrayA:	.word	9, -8, 7, -2, 5, 4, -1, 2
arrayB:	.word	-8, 10, -4, 6, 0, 2, 8, 6
arrayC:	.word	0, 0, 0, 0, 0, 0, 0, 0

# 2009/11/08 
# Author: Chris Nevison
