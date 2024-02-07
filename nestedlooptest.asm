.data
prompt: .asciiz "This program calculates nested_loop_test function.\nEnter a non-negative number less than 100: "
result: .asciiz "nested_loop_test when n = "
result2: .asciiz " = "
endl: .asciiz "\n"

.text
.globl main

main:
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s2, $v0

    move $a0, $s2
    jal nested_loop_test
    move $s3, $v0

    la $a0, result
    li $v0, 4
    syscall

    move $a0, $s2
    li $v0, 1
    syscall

    la $a0, result2
    li $v0, 4
    syscall

    move $a0, $s3
    li $v0, 1
    syscall

    la $a0, endl
    li $v0, 4
    syscall

    li $v0, 10
    syscall

nested_loop_test:
    addi $s3, $zero, 1
    addi $s0, $zero, 1
    move $s2, $a0

outer_loop:
    bge $s0, $s2, exit_loop
    move $s1, $s0

inner_loop:
    bltz $s1, update_outer_loop

    andi $t0, $s1, 1
    beqz $t0, even_branch

    sll $t1, $s0, 1
    sub $t1, $t1, $s1
    sub $t1, $t1, $s1
    add $t1, $t1, $s1
    add $s3, $s3, $t1
    j inner_loop_end

even_branch:
    add $t1, $s0, $s1
    add $s3, $s3, $t1

inner_loop_end:
    addi $s1, $s1, -1
    j inner_loop

update_outer_loop:
    sll $s0, $s0, 1
    j outer_loop

exit_loop:
    move $v0, $s3
    jr $ra
