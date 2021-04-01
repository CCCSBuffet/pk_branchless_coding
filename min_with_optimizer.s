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
.subsections_via_symbols
