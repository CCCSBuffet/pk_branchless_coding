
	.global	ToUpper3
	.align	2
	.text

ToUpper3:
	add		x2, x0, x1		// calculate the ending address
1:	cmp		x0, x2			// if x0 has advanced to x2, we're done
	beq		99f
	ldrb	w3, [x0]		// load next character to be examined
	cmp		w3, 'a'			// compare it to 'a'
	cset	w4, ge			// w4 will get 1 if letter >= 'a', 0 otherwise
	cmp		w3, 'z'			// compare it to 'z'
	cset	w5, le			// w5 will get 1 if the letter <= 'z', 0 otherwise
	and		w4, w4, w5		// and together w4 and w5 to produce 1 iff both are true
	mov		w6, 32			// all lower case letters are 32 (decimal) greater than upper case
	mul		w4, w4, w6		// this will produce 32 or 0
	sub		w3, w3, w4		// remove 32 or 0 from the current letter
	strb	w3, [x0], 1		// and store it back
	b 		1b 				// advance to the next character
99: ret


