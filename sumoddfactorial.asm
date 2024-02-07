.text
main:
    # Prompt user to input non-negative number
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5    # Read the number (n)
    syscall

    move $s2, $v0    # moves n to $s2.

    # Call function to get sum_odd_factorial
    move $a0, $s2
    jal sum_odd_factorial
    move $s3, $v0    # result is in $s3

    # Output message and n
    la $a0, result
    li $v0, 4
    syscall

    move $a0, $s2    # Print n
    li $v0, 1
    syscall

    la $a0, result2  # Print =
    li $v0, 4
    syscall

    move $a0, $s3    # Print the answer
    li $v0, 1
    syscall

    la $a0, endl # Print '\n'
    li $v0, 4
    syscall

    # End program
    li $v0, 10
    syscall

sum_odd_factorial:
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)

    move $s0, $a0      # n
    move $s2, $zero    # sum = 0
    addi $s1, $zero, 1 # i = 1

    for_sum_odd_factorial:
        slt $t0, $s0, $s1
        bne $t0, $zero, exit_sum_odd_factorial

        andi $t1, $s1, 1   # t1 = i & 1 (check if i is odd)
        beq $t1, $zero, skip_factorial

        # Call factorial(i) and add to sum
        move $a0, $s1
        jal factorial
        add $s2, $s2, $v0

        skip_factorial:
        addi $s1, $s1, 2   # i += 2 (increment by 2 for odd numbers)
        j for_sum_odd_factorial

    exit_sum_odd_factorial:
        move $v0, $s2

        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $s2, 12($sp)
        lw $s3, 16($sp)
        addi $sp, $sp, 20
        jr $ra

factorial:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0      # n
    li $s1, 1           # rv = 1
    li $t0, 1           # i = 1

    for_factorial:
        slt $t1, $t0, $s0
        beq $t1, $zero, exit_factorial

        mul $s1, $s1, $t0   # rv *= i

        addi $t0, $t0, 1    # i++
        j for_factorial

    exit_factorial:
        move $v0, $s1

        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        addi $sp, $sp, 12
        jr $ra



.data
prompt: .asciiz "This program calculates the sum of odd factorial sequence.\nEnter a non-negative number less than 100: "
result: .asciiz "Sum of odd factorials when n = "
result2: .asciiz " = "
endl: .asciiz "\n"