.data
	second:		.asciiz "Enter the seconds please : "
	row:		.asciiz "Enter the row please : "
	column:		.asciiz "Enter the column please : "
	prompt_input:  	.asciiz "Enter a character: "
	newline:        .asciiz "\n"
	
	done_message: 	.asciiz "Done\n"
	
	row_size:  	.word 0
    	col_size:  	.word 0
    	dynamic_array: 	.space 256
    	zero_array: 	.space 256
	
.text
	main:
		
		#asking second
		la $a0 second
		li $v0 4
		syscall
		
		#taking second
		li $v0 5
		syscall
		move $s6 $v0
		
		#asking row
		la $a0 row
		li $v0 4
		syscall
		
		#taking row
		li $v0 5
		syscall
		sw $v0, row_size	
		
		#asking column
		la $a0 column
		li $v0 4
		syscall
		
		#taking column
		li $v0 5
		syscall
		sw $v0, col_size		
				
       		# Allocate memory for the dynamic array
        	lw $a2, row_size
        	lw $a1, col_size
        	mul $a0, $a2, $a1  # Calculate the total size (rows * columns)
        	li $v0, 9
        	syscall
        	sw $v0, dynamic_array  # Save the base address of the dynamic array
        	
		# Fill the dynamic array with user input
        	jal fill_array

		# Move to a new line
        	li $v0, 4
        	la $a0, newline
        	syscall
        	
        	# Print the dynamic array
        	jal print_array
        	
        	# Move to a new line
        	li $v0, 4
        	la $a0, newline
        	syscall
        	
        	#Allocate memory for the new array (same size as dynamic_array)
    		lw $a2, row_size
    		lw $a1, col_size
    		mul $a0, $a2, $a1  # Calculate the total size (rows * columns)
    		li $v0, 9
    		syscall
   		sw $v0, zero_array  # Save the base address of the new array
 
	       	jal fill_zeros
	       	       	
	       # Print the zero array
        	jal arrayz_print
        	
        	# Move to a new line
        	li $v0, 4
        	la $a0, newline
        	syscall
	       	
        	jal detonate
        		
        	 # Print the zero array
        	jal arrayz_print
        	        	        	
               	# Deallocate memory
        	lw $a0, dynamic_array
        	li $v0, 10
        	syscall
        	
        	# Deallocate memory
        	lw $a0, zero_array
        	li $v0, 10
        	syscall

        	# Exit program
        	li $v0, 10
        	syscall
        	
	fill_array:
   	 	# Save registers
    		addi $sp, $sp, -8
    		sw $ra, 4($sp)
    		sw $s1, 0($sp)

    		# Load the base address of the dynamic array
    		lw $s0, dynamic_array
    
    		# Load row size and column size
    		lw $s1, row_size
    		lw $s2, col_size
    
    		# Initialize loop counters
    		li $t0, 0 # i for rows
    		li $t1, 0 # j for columns

	fill_loop:
    		bge $t0, $s1, fill_done # If i >= row_size, exit loop
    
    		li $v0, 4
    		la $a0, prompt_input
    		syscall
    
    		li $v0, 12
    		syscall
    		sb $v0, 0($s0) # Store the character in the array
    
    		addi $s0, $s0, 1 # Move to the next element in the array
    
    		addi $t1, $t1, 1 # Increment column counter
    		bge $t1, $s2, next_row # If j >= col_size, move to the next row
    
    		j fill_loop # Continue the loop

	next_row:
    		addi $t0, $t0, 1 # Move to the next row
    		li $t1, 0 # Reset column counter
    		j fill_loop # Continue the loop

	fill_done:
		#Restore registers
    		lw $ra, 4($sp)
    		lw $s1, 0($sp)
    		addi $sp, $sp, 8
    
    		jr $ra # Return from the function

		# Function to print the dynamic array
	print_array:
    		# Save registers
    		addi $sp, $sp, -8
    		sw $ra, 4($sp)
    		sw $s0, 0($sp)

    		# Load the base address of the dynamic array
    		lw $s0, dynamic_array

    		# Load row size and column size
    		lw $t3, row_size
    		lw $t1, col_size

    		# Initialize loop counters
    		li $t0, 0  # i for rows
    		li $t2, 0  # j for columns

	print_loop:
    		bge $t0, $t3, print_done  # If i >= row_size, exit loop

    		li $t2, 0  # Reset column counter for each row

	column_loop:
    		bge $t2, $t1, next_row2  # If j >= col_size, move to the next row

    		lb $a0, 0($s0)  # Load the character from the array
    		li $v0, 11      # Print character
    		syscall

    		addi $s0, $s0, 1  # Move to the next element in the array
    		addi $t2, $t2, 1  # Increment column counter
    		j column_loop  # Continue the loop

	next_row2:
    		# Print a newline character to move to the next row
    		li $v0, 11
    		li $a0, '\n'
    		syscall

   		addi $t0, $t0, 1  # Move to the next row
    		j print_loop  # Continue the loop

	print_done:
		 # Restore registers
    		lw $ra, 4($sp)
   		lw $s0, 0($sp)
    		addi $sp, $sp, 8
    		jr $ra  # Return from the function
		
	
	# Function to fill the dynamic array with zeros
	fill_zeros:
   	 # Save registers
    	addi $sp, $sp, -8
    	sw $ra, 4($sp)
    	sw $s0, 0($sp)

   	 # Load the base address of the dynamic array
    	lw $s0, zero_array

    	# Load row size and column size
    	lw $t3, row_size
    	lw $t1, col_size
	
    	# Initialize loop counters
    	li $t0, 0  # i for rows
    	li $t2, 0  # j for columns

    	fill_zeros_loop:
        bge $t0, $t3, fill_zeros_done  # If i >= row_size, exit loop

        li $t2, 0  # Reset column counter for each row

    	fill_column_loop:
        bge $t2, $t1, next_row3  # If j >= col_size, move to the next row

        # Store '0' in the array
        li $v0, 12
        li $a0, '0'
        sb $a0, 0($s0)

        addi $s0, $s0, 1  # Move to the next element in the array
        addi $t2, $t2, 1  # Increment column counter
        j fill_column_loop  # Continue the loop

    	next_row3:
        addi $t0, $t0, 1  # Move to the next row
        j fill_zeros_loop  # Continue the loop

    	fill_zeros_done:
        # Restore registers
        lw $ra, 4($sp)
        lw $s0, 0($sp)
        addi $sp, $sp, 8
        jr $ra  # Return from the function		

	arrayz_print:
    		# Save registers
    		addi $sp, $sp, -8
    		sw $ra, 4($sp)
    		sw $s0, 0($sp)

    		# Load the base address of the dynamic array
    		lw $s0, zero_array

    		# Load row size and column size
    		lw $t3, row_size
    		lw $t1, col_size

    		# Initialize loop counters
    		li $t0, 0  # i for rows
    		li $t2, 0  # j for columns

	print_loopz:
    		bge $t0, $t3, print_donez # If i >= row_size, exit loop

    		li $t2, 0  # Reset column counter for each row

	column_loopz:
    		bge $t2, $t1, next_row2z  # If j >= col_size, move to the next row

    		lb $a0, 0($s0)  # Load the character from the array
    		li $v0, 11      # Print character
    		syscall

    		addi $s0, $s0, 1  # Move to the next element in the array
    		addi $t2, $t2, 1  # Increment column counter
    		j column_loopz  # Continue the loop

	next_row2z:
    		# Print a newline character to move to the next row
    		li $v0, 11
    		li $a0, '\n'
    		syscall

   		addi $t0, $t0, 1  # Move to the next row
    		j print_loopz  # Continue the loop

	print_donez:
		 # Restore registers
    		lw $ra, 4($sp)
   		lw $s0, 0($sp)
    		addi $sp, $sp, 8
    		jr $ra  # Return from the function
 		 		 		
    		li $v0, 10
    		syscall

	detonate_loop:
    		
    		li $s5, 2         # Initialize i to 2
    		move $s7, $s6
				
		detonate_loop_start:
        	
        	bge $s5, $s7, detonate_loop_end  # If i >= seconds, exit loop
	
		li $v0, 1
		move $a0,$s5
		syscall	
        	# Print the dynamic array

 	        # Move to a new line
        	li $v0, 4
        	la $a0, newline
        	syscall
        	 	
        	jal print_array
        	
        	# Move to a new line
        	li $v0, 4
        	la $a0, newline
        	syscall
        	
        	# Print the zero array
        	jal arrayz_print
        	
        	# Move to a new line
        	li $v0, 11
        	la $a0, '\n'
        	syscall
        	
        	# Call detonate function
        	jal detonate
        	       	
 		addi $s5, $s5, 2
        	j detonate_loop_start  # Continue the loop

	detonate_loop_end:
        	
        	j exit
		
          exit:  
        	# Exit program
        	li $v0, 10
        	syscall
        	
detonate:
    # Save registers
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s0, 4($sp)

    # Load the base addresses of the dynamic array and temp array
    lw $s0, dynamic_array
    lw $s1, zero_array

    # Load row size and column size
    lw $t3, row_size
    lw $t1, col_size

    # Initialize loop counters
    li $t0, 0  # i for rows
    li $t2, 0  # j for columns

    detonate_loop2:
        bge $t0, $t3, detonate_done  # If i >= row_size, exit loop

        li $t2, 0  # Reset column counter for each row

    detonate_column_loop:
        bge $t2, $t1, next_row_detonate  # If j >= col_size, move to the next row

        # Check if the current cell in the dynamic array is a bomb ('0')
        lb $a0, 0($s0)  # Load the character from the dynamic array
        li $t4, '0'     # ASCII value for '0'
        bne $a0, $t4, not_a_bomb  # If not a bomb, skip detonation

        # Detonate the current cell and its neighbors in the temp array
        li $t5, '.'  # ASCII value for '.'
        sb $t5, 0($s1)   # (4, 4) - current cell

        # Detonate the neighbor above
        sub $t6, $s1, $t1    # Calculate the address of the neighbor above
	sb $t5, 0($t6)

        # Detonate the neighbor below
        add $t6, $s1, $t1    # Calculate the address of the neighbor below
	sb $t5, 0($t6)

        # Detonate the neighbor to the left
        sb $t5, -1($s1)

        # Detonate the neighbor to the right
        sb $t5, 1($s1)

    not_a_bomb:
        addi $s0, $s0, 1  # Move to the next element in the dynamic array
        addi $s1, $s1, 1  # Move to the next element in the temp array
        addi $t2, $t2, 1  # Increment column counter
        j detonate_column_loop  # Continue the loop

    next_row_detonate:
        addi $t0, $t0, 1  # Move to the next row
        j detonate_loop2 # Continue the loop

    detonate_done:

        # Restore registers
        lw $ra, 8($sp)
        lw $s0, 4($sp)
        addi $sp, $sp, 12

        jr $ra  # Return from the function
