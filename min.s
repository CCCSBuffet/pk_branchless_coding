	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 1
	.globl	_min1                   ; -- Begin function min1
	.p2align	2
_min1:                                  ; @min1
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w0, w0, w1, lt
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_min2                   ; -- Begin function min2
	.p2align	2
_min2:                                  ; @min2
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w0, w0, w1, lt
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ToUpper                ; -- Begin function ToUpper
	.p2align	2
_ToUpper:                               ; @ToUpper
	.cfi_startproc
; %bb.0:
	cmp	w1, #1                  ; =1
	b.lt	LBB2_22
; %bb.1:
	mov	w8, w1
	cmp	w1, #7                  ; =7
	b.hi	LBB2_3
; %bb.2:
	mov	x9, #0
	b	LBB2_23
LBB2_3:
	and	x9, x8, #0xfffffff8
	add	x10, x0, #3             ; =3
	movi.8b	v0, #159
	movi.8b	v1, #26
	mov	x11, x9
	b	LBB2_5
LBB2_4:                                 ;   in Loop: Header=BB2_5 Depth=1
	add	x10, x10, #8            ; =8
	subs	x11, x11, #8            ; =8
	b.eq	LBB2_21
LBB2_5:                                 ; =>This Inner Loop Header: Depth=1
	ldur	d2, [x10, #-3]
	add.8b	v3, v2, v0
	cmhi.8b	v3, v1, v3
	umov.b	w12, v3[0]
	tbnz	w12, #0, LBB2_13
; %bb.6:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[1]
	tbnz	w12, #0, LBB2_14
LBB2_7:                                 ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[2]
	tbnz	w12, #0, LBB2_15
LBB2_8:                                 ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[3]
	tbnz	w12, #0, LBB2_16
LBB2_9:                                 ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[4]
	tbnz	w12, #0, LBB2_17
LBB2_10:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[5]
	tbnz	w12, #0, LBB2_18
LBB2_11:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[6]
	tbnz	w12, #0, LBB2_19
LBB2_12:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v3[7]
	tbz	w12, #0, LBB2_4
	b	LBB2_20
LBB2_13:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[0]
	sub	w12, w12, #32           ; =32
	sturb	w12, [x10, #-3]
	umov.b	w12, v3[1]
	tbz	w12, #0, LBB2_7
LBB2_14:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[1]
	sub	w12, w12, #32           ; =32
	sturb	w12, [x10, #-2]
	umov.b	w12, v3[2]
	tbz	w12, #0, LBB2_8
LBB2_15:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[2]
	sub	w12, w12, #32           ; =32
	sturb	w12, [x10, #-1]
	umov.b	w12, v3[3]
	tbz	w12, #0, LBB2_9
LBB2_16:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[3]
	sub	w12, w12, #32           ; =32
	strb	w12, [x10]
	umov.b	w12, v3[4]
	tbz	w12, #0, LBB2_10
LBB2_17:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[4]
	sub	w12, w12, #32           ; =32
	strb	w12, [x10, #1]
	umov.b	w12, v3[5]
	tbz	w12, #0, LBB2_11
LBB2_18:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[5]
	sub	w12, w12, #32           ; =32
	strb	w12, [x10, #2]
	umov.b	w12, v3[6]
	tbz	w12, #0, LBB2_12
LBB2_19:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[6]
	sub	w12, w12, #32           ; =32
	strb	w12, [x10, #3]
	umov.b	w12, v3[7]
	tbz	w12, #0, LBB2_4
LBB2_20:                                ;   in Loop: Header=BB2_5 Depth=1
	umov.b	w12, v2[7]
	sub	w12, w12, #32           ; =32
	strb	w12, [x10, #4]
	b	LBB2_4
LBB2_21:
	cmp	x9, x8
	b.ne	LBB2_23
LBB2_22:
	ret
LBB2_23:
	add	x10, x0, x9
	sub	x8, x8, x9
	b	LBB2_25
LBB2_24:                                ;   in Loop: Header=BB2_25 Depth=1
	add	x10, x10, #1            ; =1
	subs	x8, x8, #1              ; =1
	b.eq	LBB2_22
LBB2_25:                                ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x10]
	sub	w11, w9, #97            ; =97
	cmp	w11, #25                ; =25
	b.hi	LBB2_24
; %bb.26:                               ;   in Loop: Header=BB2_25 Depth=1
	sub	w9, w9, #32             ; =32
	strb	w9, [x10]
	b	LBB2_24
	.cfi_endproc
                                        ; -- End function
	.globl	_ToUpper2               ; -- Begin function ToUpper2
	.p2align	2
_ToUpper2:                              ; @ToUpper2
	.cfi_startproc
; %bb.0:
	cmp	w1, #1                  ; =1
	b.lt	LBB3_8
; %bb.1:
	mov	w8, w1
	cmp	w1, #15                 ; =15
	b.hi	LBB3_3
; %bb.2:
	mov	x9, #0
	b	LBB3_6
LBB3_3:
	and	x9, x8, #0xfffffff0
	movi.16b	v0, #159
	movi.16b	v1, #26
	movi.16b	v2, #224
	mov	x10, x9
	mov	x11, x0
LBB3_4:                                 ; =>This Inner Loop Header: Depth=1
	ldr	q3, [x11]
	add.16b	v4, v3, v0
	cmhi.16b	v4, v1, v4
	add.16b	v5, v3, v2
	bsl.16b	v4, v5, v3
	str	q4, [x11], #16
	subs	x10, x10, #16           ; =16
	b.ne	LBB3_4
; %bb.5:
	cmp	x9, x8
	b.eq	LBB3_8
LBB3_6:
	add	x10, x0, x9
	sub	x8, x8, x9
LBB3_7:                                 ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x10]
	sub	w11, w9, #97            ; =97
	sub	w12, w9, #32            ; =32
	cmp	w11, #26                ; =26
	csel	w9, w12, w9, lo
	strb	w9, [x10], #1
	subs	x8, x8, #1              ; =1
	b.ne	LBB3_7
LBB3_8:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_ToUpper3               ; -- Begin function ToUpper3
	.p2align	2
_ToUpper3:                              ; @ToUpper3
	.cfi_startproc
; %bb.0:
	cmp	w1, #1                  ; =1
	b.lt	LBB4_8
; %bb.1:
	mov	w8, w1
	cmp	w1, #15                 ; =15
	b.hi	LBB4_3
; %bb.2:
	mov	x9, #0
	b	LBB4_6
LBB4_3:
	and	x9, x8, #0xfffffff0
	movi.16b	v0, #159
	movi.16b	v1, #26
	movi.16b	v2, #32
	mov	x10, x9
	mov	x11, x0
LBB4_4:                                 ; =>This Inner Loop Header: Depth=1
	ldr	q3, [x11]
	add.16b	v4, v3, v0
	cmhi.16b	v4, v1, v4
	and.16b	v4, v4, v2
	sub.16b	v3, v3, v4
	str	q3, [x11], #16
	subs	x10, x10, #16           ; =16
	b.ne	LBB4_4
; %bb.5:
	cmp	x9, x8
	b.eq	LBB4_8
LBB4_6:
	add	x10, x0, x9
	sub	x8, x8, x9
LBB4_7:                                 ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x10]
	sub	w11, w9, #97            ; =97
	cmp	w11, #26                ; =26
	cset	w11, lo
	sub	w9, w9, w11, lsl #5
	strb	w9, [x10], #1
	subs	x8, x8, #1              ; =1
	b.ne	LBB4_7
LBB4_8:
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
