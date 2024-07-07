		.data
Str1:		.asciiz "Please enter a string: "
Str2:		.asciiz "Please enter a character to count: "
Str3:		.asciiz "\nCount: "
StrBuffer:	.space 20
CharBuffer:	.space 1

		.text
Main:		# printing Str1
		la $a0, Str1
		li $v0, 4
		syscall
		
		# read input string
		la $a0, StrBuffer
		li $a1, 20
		li $v0, 8
		syscall
		
		# printing Str2
		la $a0, Str2
		li $v0, 4
		syscall
		
		# reading a character
		li $v0, 12
		syscall
		move $s0, $v0 # saving the char in $s0
		
		# loop
		add $t0, $zero, $zero # index -> t0, initialized as 0
		add $t1, $zero, $zero # counter -> t1, initialized as 0
		la $s1, StrBuffer # save address of the
Loop:		beq $t0, 20, LoopExit
		lb $t3, 0($s1)
		addi $s1, $s1, 1
		addi $t0, $t0, 1 # index ++
		bne $t3, $s0, Loop
		addi $t1, $t1, 1 # counter ++
		j Loop
		
LoopExit:	# printing Str3
		la $a0, Str3
		li $v0, 4
		syscall
		
		# printing result (int)
		li $v0, 1
		move $a0, $t1
		syscall
		
		# change a character in the string buffer
		la $t6, StrBuffer
		li $t5, 64
		sb $t5, 0($t6) 
		
		# print StrBuffer
		la $a0, StrBuffer
		li $v0, 4
		syscall
		
		
		
		j Exit

Exit:		
		
		

#int main()  
#{  
#    char string[] = "The best of both worlds";  
#    int count = 0;  
      
#    //Counts each characte
#    for(int i = 0; i < strlen(string); i++) {  
#        if(string[i] =='a')  
#            count++;  
#    }  
      
#    //Displays the total number of characters present in the given string  
#    printf("Total number of characters in a string: %d", count);  
#    return 0;  
#}  