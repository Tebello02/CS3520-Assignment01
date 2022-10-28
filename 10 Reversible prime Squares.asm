#=====================================================
#AUTHOR:TEBELLO SEPHOFANE
#CONTRACT:tsephofane@gmail.com
#A code that prints  first 10 reversible Prime Numbers
#=====================================================
.data
 message: .asciiz "10 first reversible prime squares\h"
.text
.globl main
main:
	li $v0, 4
      la $a0, message
      syscall
      jal PrintReversiblePrimes
	add $a0, $zero, $v0
	
	li $v0, 1
	syscall
	
	li $v0,10
	syscall
	 
# Implementation of isPrime(int num)
isPrime:
	addi	$t0, $zero, 2				# int x = 2
isPrimeTest:
	slt	$t1, $t0, $a0				# if (x > num)
	bne	$t1, $zero, isPrimeLoop		
	addi	$v0, $zero, 1				# It's prime!
	jr	$ra						# return 1
isPrimeLoop:						# else
	div	$a0, $t0					
	mfhi	$t3					# c = (num % x)
	slti	$t4, $t3, 1				
	beq	$t4, $zero, isPrimeLoopContinue         # if (c == 0)
	add	$v0, $zero, $zero			# its not a prime
	jr	$ra					# return 0
isPrimeLoopContinue:		
	addi $t0, $t0, 1				# x++
	j	isPrimeTest				# continue the loop
		   
ReverseNum:
      add $v0, $zero, 0        # int reverse = 0
loopReverseNum:
      ble $a0, 0, exitReverseNum
      li $t2, 10              # store 10 into register $t2
      div $a0, $t2
      mfhi $t0
      mult $v0, $t2           # reverse * 10
      mflo $t1                # $t1 = reverse * 10
      add $v0, $t1, $t0       # reverse = (reverse * 10) + remainder
      div $a0, $t2            # num / 10
      mflo $a0                # num = num / 10
      j loopReverseNum 
exitReverseNum: 
      jr $ra

SquareRoot:
	add $v0, $a0, 0 # int res = num
        li $t0, 0 # int i = 0
SquareRootLoop:
        div $t1,$a0, 2 # store num/2 into $t1
        bgt $t0, $t1, exitSquareRootLoop
        div $t4, $a0,$v0  # store num/res into $t4
        add $t3, $v0, $t4
        div $v0, $t3, 2
        add $t0, $t0, 1
        j SquareRootLoop
exitSquareRootLoop:
        jr $ra
     
IsSquareNum:
      sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $s0, 4($sp)

      move $s0, $a0
      li $v1, 0 # bool flag = 0
     
      #move $t0, $v0
      #move $a0, $t0
     jal SquareRoot
      move $t0, $v0
      move $v0, $v1
      bne $t0, $a0, exitIsSquareNum
      add $v0, $v0, 1
exitIsSquareNum:
      lw $s0, 4($sp)
      lw $ra, 0($sp)
      jr $ra
IsPalindrome:
      sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $s0, 4($sp)

      move $s0, $a0 # $s0 <- argument

      li $v1, 1 # bool flag = true

      jal ReverseNum # a function call:ReverseNum(num)
      add $t0, $v0, $zero # store the result of the function call in $t0
      move $v0, $v1
      bne $s0, $t0, exitIsPalindrome # if ($a0 != $t0) goto exit
      move $v0, $zero # if (num == ReverseNum(num)) set flag = false
exitIsPalindrome:
      lw $s0, 4($sp)
      lw $ra, 0($sp)
      add $sp, $sp, 8
      jr $ra

PrintReversiblePrimes:
	li $t1, 1 # count = 1
	li,$t2, 2 # index = 0
	li $t3, 1 # int i = 1
	bgt $t1, $t3,increment #for (i <= count)
increment: addi $t3, $t3, 1 # i++
	sub $sp ,$sp, 8
	sw $s0 ,0($sp)
	sw $ra ,4($sp)
	move $a0, $t3
	
	jal isPrime
	add $t3, $v0,$zero
	li $v0,1
	bne $t3, $v0,Return #if the output of Isprime is false(0)
Return:
	sub $sp, $sp, 8
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	
	mult $t3,$t3
	mflo $t4 # $a2 = i * i
ReveseNumCalling:
	sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $s0, 4($sp)

       move $s0, $a0 # $s0 <- argument

      li $v1, 1 # bool flag = true

      jal ReverseNum # a function call:ReverseNum(num)
      
      add $t0, $v0, $zero # store the result of the function call in $t0
      
      lw $s0, 4($sp)
      lw $ra, 0($sp)
      add $sp, $sp, 8
      li,$t5,0  # bool set = false
DisplayLoop:
	sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $t4, 4($sp)
      jal IsSquareNum
      move $a2, $t4 #....pass 
	beq $t4, $a2,IsPalindromeCalling
	move $a2,$t6
	sub $sp,$sp ,8
	lw $ra, 0($sp)
	lw $t4, 4($sp) 
IsPalindromeCalling:
	sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $t4, 4($sp)
      jal IsPalindrome
      move $a1, $t4 # storing the output 
      beq $a1, $t4,SquareRootCalling
      sub $sp,$sp ,8
	lw $ra, 0($sp)
	lw $t4, 4($sp) 

	
SquareRootCalling:
      sub $sp ,$sp, 8
	sw $s0 ,0($sp)
	sw $ra ,4($sp)
	move $a0, $t3
	
	jal SquareRoot
	add $t3, $v0,$zero # SquareRoot of Reverse(i*i)
	
	sub $sp, $sp, 8
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	
IsPrimeLastCalling:
	sub $sp ,$sp, 8
	sw $s0 ,0($sp)
	sw $ra ,4($sp)
	move $a0, $t3
	
	jal isPrime
	add $t3, $v0,$zero
	li $v0,1
	bne $t3, $v0,Return2 #if the output of Isprime is false(0)
Return2:
	sub $sp, $sp, 8
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	
      addi $t5, $zero,-1 # the value of boo set is now 0
      li,$t7,10
      blt $t2, $t7, AnotherCondition
      AnotherCondition:
      li $s1,1 
	beq $t5,$s1,Print
Print:
	#li,$v0,$t3  #cout<<num3
	addi $t2, $t2, 1 # index ++
	addi $t5, $zero, 0 #set = 0
	
 	addi $t1, $t1, 1 #count ++
 	
 	jr $ra
      	
	
		
	
	
	
	
	
	
	
	

	 
	
	
	
	
	
	
	

	
	
