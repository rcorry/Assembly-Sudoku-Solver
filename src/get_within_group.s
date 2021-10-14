                .global get_within_group
                .text

// get_within_group(board, group, n)
get_within_group:
		//x0: board
		//x1: group
		//x2: n
		//x3: #3
		//x4: row
		//x5: column
		//x6: helper
		
		//initializes
		mov	x3, #3
		mov	x4, #0
		mov	x5, #0
		mov 	x6, #0

		//calculates row value
		sdiv	x4, x1, x3
		sdiv	x5, x2, x3
		mul	x4, x4, x3
		add	x4, x4, x5	
	
		//group % 3 *3
		sdiv	x5, x1, x3
		mul	x5, x5, x3
		sub	x5, x1, x5
		mul	x5, x5, x3
		// n%3 + x5
		//finishes calulating group value
		sdiv	x6, x2, x3
		mul	x6, x6, x3
		sub	x6, x2, x6
		add	x5, x5, x6
		
		//calculates index
		mov 	x6, #9
		mul	x4, x4, x6
		add	x4, x4, x5
		
		ldrb	w6, [x0, x4]
		
		mov 	x0, x6
                ret

	




/*
def get_within_group(board, group, n):
    row = (group / 3) * 3 + (n / 3)
    column = (group % 3) * 3 + (n % 3)
    index = row * 9 + column
    return board[index]
*/
