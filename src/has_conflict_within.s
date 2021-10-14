                .global has_conflict_within
                .text

// has_conflict_within(board, get_within, major) -> 0 or 1
has_conflict_within:
		//x19: board
		//x20: get_within
		//x21: major
		//x22: minor
		//x23: used
		//x4:  cell 
		//x3: bit_position
		sub	sp, sp, #48
		str	x19, [sp, #0]
		str	x20, [sp, #8]
		str	x21, [sp, #16]
		str	x22, [sp, #24]
		str	x23, [sp, #32]
		str	x30, [sp, #48]
		
		mov	x19, x0
		mov 	x20, x1
		mov	x21, x2 
		mov	x22, #0
		mov	x23, #0
	

loop:
		//ends loop if i > 8
		cmp	x22, #9
		b.ge	end_loop		
		
		//moves board, major, and i into x0, x1, x2 and calls get_within
		mov	x0, x19
		mov	x1, x21
		mov 	x2, x22						
		blr	x20

		//sets up bit_position shift
		mov	x3, #1
		mov	x4, x0

		//checks for a digit vs a zero
		cmp	x4, #0
		b.le	next_loop	

		//Does the shifting for bit position, and checks for conflict
		lsl	x3, x3, x4
		and 	x5, x23, x3
		cmp	x5, #0
		b.ne	ret_one	
		orr	x23, x23, x3
		b	next_loop		
		
		

next_loop:
		//i+=1
		add	x22, x22, #1
		b	loop

ret_one:
	ldr 	x19, [sp, #0]
	ldr	x20, [sp, #8]
	ldr	x21, [sp, #16]
	ldr	x22, [sp, #24]
	ldr	x23, [sp, #32]
	ldr	x30, [sp, #48]
	add 	sp, sp, #48
	mov 	x0, #1
	ret
	
end_loop:
	ldr 	x19, [sp, #0]
	ldr	x20, [sp, #8]
	ldr	x21, [sp, #16]
	ldr	x22, [sp, #24]
	ldr	x23, [sp, #32]
	ldr	x30, [sp, #48]
	add 	sp, sp, #48
	mov	x0, xzr
	ret


