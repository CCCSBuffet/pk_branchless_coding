# Branchless coding

These examples are drawn from [here](https://www.youtube.com/watch?v=bVJ-mWWL7cE).

Modern highly pipelined processors have multiple instructions in-progress at any one time. Speculation exists that the Apple M1 ARM-based SoC keeps 8 instructions in-progress. When conditional branch instructions are encountered, one of two paths will be chosen and one will not be chosen. To keep multiple instructions in-progress, the CPU will follow one branch hoping it is the one which will actually be chosen. If the branch goes down the path the CPU did not expect, the work done fetching, decoding and executing some instructions may turn out to be wasted.

## Trivial example

### High level language

Consider this code:

```c++
int min(int a, int b) {
    if (a < b)
        return a;
    else
        return b;
}
```

or:

```c++
int min(int a, int b) {
    return (a < b) ? a : b;
}
```

the CPU might choose to assume that `a` will be returned. If `b` turns out to be smaller, the instruction pipeline must toss its work (which assumed `a` would be returned).

### Low level language

On the AARCH64 ISA, the above might be implemented in this way:

```text
min:    cmp    w0, w1
        ble    1f
        mov    w0, w1
1:      ret
```

If the CPU is designed to always take conditional branches, the pipeline will stall whenever `b` is smaller than `a`.

### Eliminating the branch

Consider this code:

```c++
int min(int a, int b) {
    return a * (a < b) + b * (b <= a);
}
```

In this implementation, there is no branch. One of `(a < b)` or `(b <= a)` will be true and the other false. The true expression will evaluate to `1` and the false expression will evaluate to `0`. As a consequence, one of `a` or `b` will be returned based upon which is smaller.

You might imagine that the above code will generate:

```text
min: 
    cmp     w0, w1
    cset    w2, lt
    mul     w2, w2, w0
    cmp     w1, w0
    cset    w3, le
    mul     w3, w3, w1
    add     w0, w2, w3
    ret
```

The `cset` instruction is the magic which acts like a branch but is completely atomic - a single instruction which stores in the destination register a `1` or `0` depending on the state of the condition bits that are set.

### However, in this case the optimizer is smarter than you

Instead, this is the code that is generated:

```text
min:
    cmp    w0, w1
    csel   w0, w0, w1, lt
    ret
```

The optimizer notices what you're trying to do and replaces the branch with an even shorter sequence of instructions. The `cmp` sets condition bits then the `csel` instruction performs what amounts to a conditional expression. That is, these two instructions implement exactly this:

```text
(a < b) ? a : b;
```

without branches.

### Moral of the story so far

Branchless programming can provide big wins except when the ISA and compiler designers get together and notice things about your code that they can do a better job with.

## A more complex example

Take this code:

```c++
void ToUpper(char * s, int count) {
    for (int i = 0; i < count; i++) {
        if (s[i] >= 'a' && s[i] <= 'z')
            s[i] -= 32;
    }
}
```

This generates a LOT of code when fully optimized. One hundred twenty nine lines (129), in fact.

Looking at this redone using the same technique of multiplying by `0` or `1` based on condition bits, it might look like this:

```c++
void ToUpper2(char *s, int count)
{
    for (int i = 0; i < count; i++) {
        s[i] = 
            s[i] * !(s[i] >= 'a' && s[i] <= 'z') +
            (s[i] - 32) * (s[i] >= 'a' && s[i] <= 'z');
    }
}
```

This code generates only forty four (44) instructions.

Let's look at a different version:

```c++
void ToUpper3(char *s, int count)
{
    for (int i = 0; i < count; i++) {
        s[i] -= 32 * (s[i] >= 'a' && s[i] <= 'z');
    }
}
```

Interestingly, the compilier generates about the same number of lines of assembly as the previous example. Still, this is 1/3 the number of lines as the original with braches. I must say I am surprised how verbose the generated code is. I expected it to be much closer to the hand-made assembly language, presented next.

### Hand made branchless version

Let's try writing this by hand:

```text
ToUpper3:
	add	x2, x0, x1	// calculate the ending address
1:	cmp	x0, x2		// if x0 has advanced to x2, we're done
	beq	99f
	ldrb	w3, [x0]	// load next character to be examined
	cmp	w3, 'a'		// compare it to 'a'
	cset	w4, ge		// w4 will get 1 if letter >= 'a', 0 otherwise
	cmp	w3, 'z'		// compare it to 'z'
	cset	w5, le		// w5 will get 1 if the letter <= 'z', 0 otherwise
	and	w4, w4, w5	// and together w4 and w5 to produce 1 iff both are true
	mov	w6, 32		// all lower case letters are 32 (decimal) greater than upper case
	mul	w4, w4, w6	// this will produce 32 or 0
	sub	w3, w3, w4	// remove 32 or 0 from the current letter
	strb	w3, [x0], 1	// and store it back and advance the source pointer
	b 	1b 		// advance to the next character
99: ret
```

This code is far smaller and faster than the original and is also branchless with the exception of the loop index control.

## Bottom line

It is worth considering reorganizing your code to be branchless however:

1. Remember one of the cardinal rules of Computer Science: `only optimize what needs optimizing.`

2. Remember that optimizers are generally smarter than you are.

3. Sometimes writing branchless code in a higher level language does not bring with it the gains you might hope for.

4. Always confirm your efforts at making your code faster actually made your code faster.

## Wisconsin connection

The invention of speculative execution has many contributors including two primary inventors from the University of Wisconsin - Madison: Mark Hill, now retired, and Guri Sohi. I worked for both of these researchers when they were Chairs of the CS department there.
