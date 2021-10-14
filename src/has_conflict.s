                .global has_conflict
                .text

// has_conflict(board) -> 0 or 1
has_conflict:
		sub	sp, sp, #48
		str	x19, [sp, #8]
		str	x21, [sp, #16]
		str	x30, [sp, #48] 

		mov	x19, x0
		mov	x21, #0

loop:
		cmp	x21, #9
		b.ge	no_conflict	

		mov	x0, x19
		ldr	x1, =get_within_row
		mov	x2, x21
		bl	has_conflict_within
		cmp	x0, #0
		b.ne	conflict

		mov	x0, x19
		ldr	x1, =get_within_column
		mov	x2, x21
		bl	has_conflict_within
		cmp	x0, #0
		b.ne	conflict

		mov	x0, x19
		ldr	x1, =get_within_group
		mov	x2, x21
		bl	has_conflict_within
		cmp	x0, #0
		b.ne	conflict


		add	x21, x21, #1
		b	loop	
 
no_conflict:
		ldr	x19, [sp, #8]
		ldr	x21, [sp, #16]
		ldr	x30, [sp, #48]
		add	sp, sp, #48

		mov	x0, xzr
		ret	

conflict:
		ldr	x19, [sp, #8]
		ldr	x21, [sp, #16]
		ldr	x30, [sp, #48]
		add	sp, sp, #48	

		mov	x0, #1
		ret
		




/*
def has_conflict(board):
    for i = 0; i < 9; i++
        if has_conflict_within(board, get_within_row, i) != 0:
            return 1
        if has_conflict_within(board, get_within_column, i) != 0:
            return 1
        if has_conflict_within(board, get_within_group, i) != 0:
            return 1
    return 0
```

This function must call other functions so you must carefully plan your
register usage and use the stack to preserve values that you must later
restore.

You can load the address of a function just like you would any other
global value:

    ldr x1, =get_within_row

Test with a valid board using `start.s`, then test it a few more times where
there is an invalid row, column, or group. Once you are confident that
everything works, move on to using `make test` to run the unit tests.
*/
