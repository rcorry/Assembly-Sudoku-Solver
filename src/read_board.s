                .global read_board
                .text

// read_board(*input, *board) ->
//     0 for success
//     1 for input too short
//     2 for input contains invalid character
//     3 for input too long
read_board:
	mov 	x2, #0
	mov 	x3, #0
	mov	x5, #0
	mov	x6, #0

loop:
	/*
	x0: Given Board
	x1: Created Board
	x2: Position Counter
	x3: Value at Position
	*/

	ldrb 	w3 , [x0, x2]

	cmp 	x2, #81
	b.gt	too_long
	cmp	x3, #0
	b.eq	end_of_list
	cmp	x3, #'.'
	b.eq	add_zero
	cmp	x3, #'1'
	b.ge	check_number
	b.lt	invalid_entry

add_zero:
	str	x6 , [x1, x2]
	ldrb	w5 , [x1, x2]
	add	x2, x2, #1
	b	loop	

check_number:
	cmp	x3, #'9'
	b.gt	invalid_entry
	sub	x3, x3, #'0'
	str	x3, [x1, x2]
	ldrb	w5, [x1, x2]
	add 	x2, x2, #1
	b	loop	

end_of_list:
	cmp	x2, #81
	b.lt	too_short
	mov	x0, #0
	ret

too_short:
	mov	x0, #1
	ret

too_long:
	mov 	x0, #3
	ret 

invalid_entry:
	mov	x0, #2
	ret








/*
def read_board(input, board):
    for i = 0; i < 81; i++
        ch = input[i]

        // was the input too short?
        if ch == 0:
            return 1

        // was it an unfilled square?
        else if ch == '.':
            board[i] = 0

        // was it a filled square?
        else if ch >= '1' and ch <= '9':
            board[i] = ch - '0'

        // anything else is invalid
        else:
            return 2

    // was the input too long?
    if input[i] != 0:
        return 3

    // success
    return 0
As it reads, the function should validate the input. If it is too
short, it should return 1. If it encounters an invalid character
(not a dot or a digit) then it should return 2. If the string is too
long it should return 3.
*/
