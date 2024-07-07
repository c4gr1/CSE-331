		.data
Str1:		.asciiz "Please enter a number: "
Str2:		.asciiz "Please enter 1 for addition, 2 for sub, 3 for bitwise-and, 4 for bitwise-or, 5 for exit\n"
StrResult:	.asciiz "The result is "

		.text
Main:		# print str1
		la $a0, Str1
		li $v0, 4
		syscall

		# read integer a
		li $v0, 5
		syscall
		move $s0, $v0 # scanf("%d", &s0)
		
		# print str1
		la $a0, Str1
		li $v0, 4
		syscall
		
		# read integer b
		li $v0, 5
		syscall
		move $s1, $v0

		# print str2
		la $a0, Str2
		li $v0, 4
		syscall

		# read integer selection
		li $v0, 5
		syscall
		move $s2, $v0

		# if addition (selection == 1)
		beq $s2, 1, Addition
		
		
		# if subtraction
		beq $s2, 2, Subtraction
		
		# if bitwise-and
		beq $s2, 3, BitwiseAnd
		
		# if BitwiseOr
		beq $s2, 4, BitwiseOr
		
		# if Exit
		beq $s2, 5, Exit
		
		j Main 
		
Addition:	jal PrintString
		# add and print the result
		add $a0, $s0, $s1
		li $v0, 1
		syscall
		j Exit
		

Subtraction:	jal PrintString
		# sub and print the result
		sub $a0, $s0, $s1
		li $v0, 1
		syscall
		j Exit
	

BitwiseAnd:	jal PrintString
		# bitwiseand and print the result
		and $a0, $s0, $s1
		li $v0, 1
		syscall
		j Exit
	

BitwiseOr:	jal PrintString
		# bitwiseor and print the result
		or $a0, $s0, $s1
		li $v0, 1
		syscall
		j Exit
	

PrintString:	# print StrResult
		la $a0, StrResult
		li $v0, 4
		syscall
		jr $ra 

Exit:		li $v0, 10
		syscall

# int a, b, selection;
# printf("Please enter a number");
# scanf("%d", &a);
# printf("Please enter a number");
# scanf("%d", &b);
# printf("Please enter 1 for addition, 2 for sub, 3 for bitwise-and, 4 for bitwise-or, 5 for exit");
# scanf("%d", &selection);

# if (selection == 1)
# 	addition (a,b);
# else if (selection == 2)
#	subtract (a,b);
# ...
# else 
# 	exit(0);
# return 0;

# void addition (int a , int b)
# {
# 	printf("The result is: %d", a+b);
#	return;
# }
