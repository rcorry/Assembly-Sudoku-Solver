                .global solve
                .text

// solve(board) -> 0 for success, 1 for failure
// on success, the board will be solved
// on failure, the board will be unchanged
solve:
	//x19: board
	//x20: i
	//x21: n

	sub 	sp, sp, #48
	str	x19, [sp, #8]
	str	x20, [sp, #16]
	str	x21, [sp, #24]
	str 	x30, [sp, #48]

	mov	x19, x0
	mov	x20, #0
	mov	x21, #1

	//checks for conflicts
	bl	has_conflict
	cmp 	x0, #0
	b.ne	restore_values //return 1


i_loop:
	//ends loop if i > 80
	cmp	x20, #80
	b.gt	restore_values //return 0	

	//loads board[i] into x1 and checks for a zero
	ldrb	w1, [x19, x20]
	cmp	x1, xzr
	b.ne	entry_given		

 	b	n_loop

entry_given:
	//continues i loop
	add	x20, x20, #1
	b	i_loop

n_loop:
	//exits if n > 9
	cmp 	x21, #9
	b.gt	keep_zero
	
	//stores n into board and recurses
	strb	w21, [x19, x20]
	mov	x0, x19
	bl	solve
	cmp	x0, xzr
	b.eq	restore_values //return 0	
	
	add	x21, x21, #1
	b	n_loop

keep_zero:
	//executes if no n for board[i]=n works
	strb	wzr, [x19, x20]
	mov 	x0, #1
	b	restore_values //return 1


restore_values:
	
	//restores callee saved registers and returns 
	ldr	x19, [sp, #8] 
	ldr	x20, [sp, #16]
	ldr	x21, [sp, #24]
	ldr	x30, [sp, #48]
	add	sp, sp, #48
	
	cmp	x0, #0
	b.ne	return_one
	ret


return_one:
	mov	x0, #1
	ret
