# posrun.s 
# An assembly language outline of the C++ program posrun.cpp

# Student:	Jonah Fidel 	9/8/14

.text
.globl	posrun

# Preconditions:
#   1st parameter (a0) address of the first element of the array
#   2nd parameter (a1) size of the array
# Postconditions:	
#   result (v0) length of the longest consecutive run of positive
#     numbers in the array

posrun:	addi $t0,$zero, 0	# t0 is count, count = 0
	addi $v0,$zero, 0	# v0 is maxrun, maxrun = 0
	addi $t1,$zero, 0 	# t1 is k, k = 0
for:	slt  $t5,$t1, $a1	# (k < size) ?
	beq  $t5,$zero,endfor   # if not, branch to end of loop
	sll  $t2,$t1,2		# t2 = 4*k
	add  $t3,$a0,$t2	# t3 = address of list[k]
	lw   $t4,0($t3)		# t4 = list[k]
	slt  $t5,$zero,$t4	# (0 < list[k]) ?
	beq  $t5,$zero,else1	# if not, branch to else
if1:	addi $t0,$t0,1		# count++
	j    endif1		# branch to end of if
else1:	add  $t0,$zero,$zero	# count = 0
endif1:	slt  $t5,$v0,$t0	# (maxrun < count) ?
	beq  $t5,$zero,endif2	# if not, branch to end of if
if2:	add  $v0,$zero,$t0	# maxrun = count
endif2:	add  $t1,$t1,1		# k++
	j    for 		# back to top of loop
endfor:	jr   $ra		# return

# $Id: posrun.s,v 1.3 2006/05/25 13:59:26 parks Exp $
# Authors: Chris Nevison and Thomas M. Parks
