                .global get_within_column
                .text

// get_within_column(board, column, n)
get_within_column:

		//x0: board
		//x1: column
		//x2: n
		//x3: helper
		//x4: holds #9

		mov	x3, #0
		mov 	x4, #9

		//multiplies n *9 and add that to the column
		mul	x2, x2, x4
		add	x2, x2, x1

		//loads the value at the given index into x3, and moves that into x0 then returns
		ldrb	w3, [x0, x2]
		mov 	x0, x3
                ret





