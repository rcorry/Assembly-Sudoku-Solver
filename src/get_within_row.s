                .global get_within_row
                .text

// get_within_row(board, row, n)
get_within_row:

		//x0: board
		//x1: row
		//x2: n
		//x3: helper
		//x4: stores #9

		mov 	x3, #0
		mov	x4, #9

		//multiplies the row value by 9 and then adds n to it
		mul	x1, x1, x4 
		add	x1, x1, x2

		//gets the the value at index row*9+n and returns it
		ldrb	w3, [x0, x1]
		mov 	x0, x3
                ret
