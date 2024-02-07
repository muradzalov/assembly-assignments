.text
main:
# Prompt user to input non-negative number
la $a0,prompt   
li $v0,4
syscall

li $v0,5    #Read the number(n)
syscall

move $s2,$v0    # moves n to $s2. 

# Call function to get cube_sum #n
move $a0,$s2	#alternatively, addi $a0, $s2, 0
jal cube_sum    #call cube_sum (n)
move $s3,$v0    #result is in $s3

# Output message and n
la $a0,result   #Print C_
li $v0,4
syscall

move $a0,$s2    #Print n
li $v0,1
syscall

la $a0,result2  #Print =
li $v0,4
syscall

move $a0,$s3    #Print the answer
li $v0,1
syscall

la $a0,endl #Print '\n'
li $v0,4
syscall

# End program
li $v0,10
syscall

#int cube_sum(int n){int sum = 0;
#for(int i = 0; i <= n;i++)sum+=cube(i);
#return sum;}
cube_sum:
# Compute and return cube_sum number
#Push $ra $s0, and $s1 to stack
addi $sp,$sp,-16
sw $ra,0($sp)   #storing return address in stack
sw $s0,4($sp)   #storing first saved register in stack
sw $s1,8($sp)   #storing second saved register in stack
sw $s2,12($sp)   #storing third saved register in stack

move $s0, $a0	#n is now stored in $s0
move $s2, $zero	#sum is now stored in $s2 and initialized to zero
addi $s1, $zero, 1	#i is stored in $s1 and initialized to 1
for: slt $t0, $s0, $s1
bne $t0, $zero, exit
#body of for loop
move $a0, $s1
jal cube
add $s2, $s2, $v0	#sum += cube(i)
#end of for loop
addi $s1, $s1, 1
j for
exit:
move $v0, $s2	#returning sum
lw $ra,0($sp)   #restoring return address from stack
lw $s0,4($sp)   #restoring first saved register from stack
lw $s1,8($sp)   #restoring second saved register from stack
lw $s2,12($sp)   #restoring third saved register from stack
addi $sp,$sp,16
jr $ra

#int cube(int n){
#	return n*n*n;
#}
cube:
#compute the cube of a number
mul $t0, $a0, $a0
mul $t0, $t0, $a0
move $v0, $t0
jr $ra

.data
prompt: .asciiz "This program calculates the sum of cube sequence.\nEnter a non-negative number less than 100: "
result: .asciiz "C_"
result2: .asciiz " = "
endl: .asciiz "\n"
