# towers.s - Solve the Towers of Hanoi puzzle.
# Print each move and return the total number
# of moves needed to solve the puzzle.
#
# Author:	Chris Nevison	1997/09/22
# Revised:	Tom Parks	2002/09/27

# Student:	Jonah Fidel	9/22/14

.text 
.globl towers 

# Preconditions:	
#   1st parameter (a0) numDiscs, number of discs to move
#   2nd parameter (a1) start, starting peg
#   3rd parameter (a2) goal, ending peg
# Postconditions:
#   result (v0) steps, total number of steps required to solve puzzle

towers:	sw $ra, 16($sp)		# preserve return address
	sw $s0, 12($sp)		# make space on stack
	sw $s1, 8($sp)		# preserve registers used by this function
	sw $s2, 4($sp)
	sw $s3, 0($sp)           
	addi $t0, $a0, 0        # Transfer parameters to temporary registers
	addi $t1, $a1, 0
	addi $t2, $a2, 0
	addi $t3, $v0, 0
		
if:	addi $t4, $zero, 2
	slt $t5, $t0, $t4	# numDiscs < 2
	beq $t5, $zero, else	# if not, go to else 

	addi $a0, $t1, 0	# 1st parameter = start
	addi $a1, $t2, 0	# 2nd parameter = goal
	jal print 		# call print function

	addi $ra, $zero, 1	# return value = 1 
	j endif			# jump past else 

else:	addi $s1, $zero, 6	# s1 = peg = 6
	sub $s1, $s1, $a0	# peg = peg - start 
	sub $s1, $s1, $a1	# peg = peg - goal = 6 - start - goal 

	addi $a0, $t0, -1 	# 1st parameter = numDiscs - 1
	addi $a1, $t1, 0	# 2nd parameter = start
	addi $a2, $s1, 0	# 3rd parameter = peg
	j towers		# recursive call to towers 
	addi $s0, $v0, 0	# s0 = steps = result

	addi $a0, $zero, 1	# 1st parameter = 1
	addi $a1, $t1, 0	# 2nd parameter = start
	addi $a2, $t2, 0	# 3rd parameter = goal
	j towers		# recursive call to towers 
	add $s0, $s0, $t3	# steps = steps + result 

	addi $a0, $t0, -1	# 1st parameter = numDiscs - 1
	addi $a1, $s1, 0	# 2nd parameter = peg
	addi $a2, $t2, 0	# 3rd parameter = goal
	j towers		# recursive call to towers 
	add $ra, $s0, $t3	# return value = steps + result

endif:	lw $s3, 16($sp)		# restore stack pointer
	lw $s2, 12($sp)		# restore registers used by this function
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)		# restore return address 
	
	jr $ra			# return 

# $Id: towers.s,v 1.2 2003/08/29 18:08:50 parks Exp $
