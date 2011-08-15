	.file	"a1q1.C"
! GNU C++ version 3.4.2 (sparc-sun-solaris2.8)
!	compiled by GNU C version 3.4.2.
! GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
! options passed:  -iprefix -mcpu=v7 -auxbase-strip -fverbose-asm
! options enabled:  -feliminate-unused-debug-types -fpeephole
! -ffunction-cse -fkeep-static-consts -fpcc-struct-return -fgcse-lm
! -fgcse-sm -fgcse-las -fsched-interblock -fsched-spec
! -fsched-stalled-insns -fsched-stalled-insns-dep -fbranch-count-reg
! -fcommon -fverbose-asm -fargument-alias -fzero-initialized-in-bss -fident
! -fmath-errno -ftrapping-math -mcpu=v7

	.section	".text"
	.align 4
	.type	_ZSt17__verify_groupingPKcjRKSs, #function
	.proc	04
_ZSt17__verify_groupingPKcjRKSs:
.LLFB1319:
	!#PROLOGUE# 0
	save	%sp, -144, %sp
.LLCFI0:
	!#PROLOGUE# 1
	st	%i0, [%fp+68]	! __grouping, __grouping
	st	%i1, [%fp+72]	! __grouping_size, __grouping_size
	st	%i2, [%fp+76]	! __grouping_tmp, __grouping_tmp
	ld	[%fp+76], %o0	! __grouping_tmp, __grouping_tmp
	call	_ZNKSs4sizeEv, 0
	 nop	!,
	mov	%o0, %g1	!, tmp108
	add	%g1, -1, %g1	! tmp108,, tmp109
	st	%g1, [%fp-20]	! tmp109, __n
	add	%fp, -20, %o5	!,, tmp110
	ld	[%fp+72], %g1	! __grouping_size, __grouping_size
	add	%g1, -1, %g1	! __grouping_size,, tmp113
	st	%g1, [%fp-28]	! tmp113,
	add	%fp, -28, %g1	!,, tmp114
	mov	%o5, %o0	! tmp110,
	mov	%g1, %o1	! tmp114,
	call	_ZSt3minIjERKT_S2_S2_, 0
	 nop	!,
	mov	%o0, %g1	!, tmp115
	ld	[%g1], %g1	!, tmp116
	st	%g1, [%fp-24]	! tmp116, __min
	ld	[%fp-20], %g1	! __n, __n
	st	%g1, [%fp-32]	! __n, __i
	mov	1, %g1	!, tmp118
	stb	%g1, [%fp-33]	! tmp118, __test
	st	%g0, [%fp-40]	!, __j
.LL2:
	ld	[%fp-40], %o5	! __j, __j
	ld	[%fp-24], %g1	! __min, __min
	cmp	%o5, %g1	! __j, __min
	bgeu	.LL5	!
	nop
	ldub	[%fp-33], %g1	! __test, __test
	and	%g1, 0xff, %g1	! __test, __test
	cmp	%g1, 0	! __test,
	be	.LL5	!
	nop
	ld	[%fp+76], %o0	! __grouping_tmp, __grouping_tmp
	ld	[%fp-32], %o1	! __i, __i
	call	_ZNKSsixEj, 0
	 nop	!,
	mov	%o0, %o4	!, tmp123
	ld	[%fp+68], %o5	! __grouping, __grouping
	ld	[%fp-40], %g1	! __j, __j
	add	%o5, %g1, %o5	! __grouping, __j, tmp124
	ldub	[%o4], %g1	!, tmp128
	sll	%g1, 24, %g1	! tmp128,, tmp129
	sra	%g1, 24, %o4	! tmp129,, tmp127
	ldub	[%o5], %g1	!, tmp131
	sll	%g1, 24, %g1	! tmp131,, tmp132
	sra	%g1, 24, %g1	! tmp132,, tmp130
	xor	%o4, %g1, %g1	! tmp127, tmp130, tmp134
	subcc	%g0, %g1, %g0	! tmp134
	subx	%g0, -1, %g1	! tmp133
	stb	%g1, [%fp-33]	! tmp133, __test
	ld	[%fp-32], %g1	! __i, __i
	add	%g1, -1, %g1	! __i,, tmp136
	st	%g1, [%fp-32]	! tmp136, __i
	ld	[%fp-40], %g1	! __j, __j
	add	%g1, 1, %g1	! __j,, tmp138
	st	%g1, [%fp-40]	! tmp138, __j
	b	.LL2
	 nop	!
.LL5:
	ld	[%fp-32], %g1	! __i, __i
	cmp	%g1, 0	! __i,
	be	.LL6	!
	nop
	ldub	[%fp-33], %g1	! __test, __test
	and	%g1, 0xff, %g1	! __test, __test
	cmp	%g1, 0	! __test,
	be	.LL6	!
	nop
	ld	[%fp+76], %o0	! __grouping_tmp, __grouping_tmp
	ld	[%fp-32], %o1	! __i, __i
	call	_ZNKSsixEj, 0
	 nop	!,
	mov	%o0, %o4	!, tmp142
	ld	[%fp+68], %o5	! __grouping, __grouping
	ld	[%fp-24], %g1	! __min, __min
	add	%o5, %g1, %o5	! __grouping, __min, tmp143
	ldub	[%o4], %g1	!, tmp147
	sll	%g1, 24, %g1	! tmp147,, tmp148
	sra	%g1, 24, %o4	! tmp148,, tmp146
	ldub	[%o5], %g1	!, tmp150
	sll	%g1, 24, %g1	! tmp150,, tmp151
	sra	%g1, 24, %g1	! tmp151,, tmp149
	xor	%o4, %g1, %g1	! tmp146, tmp149, tmp153
	subcc	%g0, %g1, %g0	! tmp153
	subx	%g0, -1, %g1	! tmp152
	stb	%g1, [%fp-33]	! tmp152, __test
	ld	[%fp-32], %g1	! __i, __i
	add	%g1, -1, %g1	! __i,, tmp155
	st	%g1, [%fp-32]	! tmp155, __i
	b	.LL5
	 nop	!
.LL6:
	ld	[%fp+76], %o0	! __grouping_tmp, __grouping_tmp
	mov	0, %o1	!,
	call	_ZNKSsixEj, 0
	 nop	!,
	mov	%o0, %o4	!, tmp157
	ld	[%fp+68], %o5	! __grouping, __grouping
	ld	[%fp-24], %g1	! __min, __min
	add	%o5, %g1, %o5	! __grouping, __min, tmp158
	ldub	[%o4], %g1	!, tmp162
	sll	%g1, 24, %g1	! tmp162,, tmp163
	sra	%g1, 24, %o4	! tmp163,, tmp161
	ldub	[%o5], %g1	!, tmp165
	sll	%g1, 24, %g1	! tmp165,, tmp166
	sra	%g1, 24, %g1	! tmp166,, tmp164
	cmp	%o4, %g1	! tmp161, tmp164
	bg	.LL8	!
	nop
	ldub	[%fp-33], %g1	! __test, __test
	and	%g1, 0xff, %g1	! __test, __test
	and	%g1, 1, %g1	! __test,, tmp169
	stb	%g1, [%fp-41]	! tmp169,
	b	.LL9
	 nop	!
.LL8:
	stb	%g0, [%fp-41]	!,
.LL9:
	ldub	[%fp-41], %g1	!,
	stb	%g1, [%fp-33]	!, __test
	ldub	[%fp-33], %g1	! __test, __test
	and	%g1, 0xff, %g1	! __test, __test
	mov	%g1, %i0	! <result>, <result>
	ret
	restore
.LLFE1319:
	.size	_ZSt17__verify_groupingPKcjRKSs, .-_ZSt17__verify_groupingPKcjRKSs
	.local	_ZSt8__ioinit
	.common	_ZSt8__ioinit,1,1
	.global .rem
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
.LLFB1400:
	!#PROLOGUE# 0
	save	%sp, -160, %sp
.LLCFI1:
	!#PROLOGUE# 1
	st	%g0, [%fp-20]	!, ip
	ld	[%fp-20], %o0	! ip, ip
	call	_ZdlPv, 0
	 nop	!,
	st	%g0, [%fp-24]	!, i
.LL11:
	ld	[%fp-24], %g1	! i, i
	sethi	%hi(499712), %o5	!, tmp110
	or	%o5, 287, %o5	! tmp110,, tmp109
	cmp	%g1, %o5	! i, tmp109
	bg	.LL12	!
	nop
	ld	[%fp-24], %g1	! i, i
	mov	%g1, %o0	! i, i
	mov	10, %o1	!,
	call	.rem, 0
	 nop	!,
	mov	%o0, %g1	!, tmp118
	mov	%g1, %o4	! tmp118, tmp111
	mov	%o4, %g1	! tmp111, tmp119
	sll	%g1, 2, %o5	! tmp119,, tmp120
	add	%fp, -16, %g1	!,, tmp130
	add	%o5, %g1, %o3	! tmp120, tmp130, tmp121
	mov	%o4, %g1	! tmp111, tmp122
	sll	%g1, 2, %o5	! tmp122,, tmp123
	add	%fp, -16, %g1	!,, tmp131
	add	%o5, %g1, %g1	! tmp123, tmp131, tmp124
	ld	[%g1-48], %g1	! ip, tmp125
	add	%g1, 1, %g1	! tmp125,, tmp126
	st	%g1, [%o3-48]	! tmp126, ip
	ld	[%fp-24], %g1	! i, i
	add	%g1, 1, %g1	! i,, tmp128
	st	%g1, [%fp-24]	! tmp128, i
	b	.LL11
	 nop	!
.LL12:
	mov	0, %g1	!, <result>
	mov	%g1, %i0	! <result>, <result>
	ret
	restore
.LLFE1400:
	.size	main, .-main
	.section	".gnu.linkonce.t._ZSt3minIjERKT_S2_S2_",#alloc,#execinstr
	.align 4
	.weak	_ZSt3minIjERKT_S2_S2_
	.type	_ZSt3minIjERKT_S2_S2_, #function
	.proc	0116
_ZSt3minIjERKT_S2_S2_:
.LLFB1401:
	!#PROLOGUE# 0
	save	%sp, -120, %sp
.LLCFI2:
	!#PROLOGUE# 1
	st	%i0, [%fp+68]	! __a, __a
	st	%i1, [%fp+72]	! __b, __b
	ld	[%fp+72], %g1	! __b, __b
	ld	[%fp+68], %i5	! __a, __a
	ld	[%g1], %i4	!* __b, tmp110
	ld	[%i5], %g1	!* __a, tmp111
	cmp	%i4, %g1	! tmp110, tmp111
	bgeu	.LL15	!
	nop
	ld	[%fp+72], %g1	! __b, __b
	st	%g1, [%fp-20]	! __b, <result>
	b	.LL14
	 nop	!
.LL15:
	ld	[%fp+68], %g1	! __a, __a
	st	%g1, [%fp-20]	! __a, <result>
.LL14:
	ld	[%fp-20], %i0	! <result>, <result>
	ret
	restore
.LLFE1401:
	.size	_ZSt3minIjERKT_S2_S2_, .-_ZSt3minIjERKT_S2_S2_
	.section	".text"
	.align 4
	.type	_Z41__static_initialization_and_destruction_0ii, #function
	.proc	020
_Z41__static_initialization_and_destruction_0ii:
.LLFB1407:
	!#PROLOGUE# 0
	save	%sp, -112, %sp
.LLCFI3:
	!#PROLOGUE# 1
	st	%i0, [%fp+68]	! __initialize_p, __initialize_p
	st	%i1, [%fp+72]	! __priority, __priority
	ld	[%fp+72], %g1	! __priority, __priority
	sethi	%hi(64512), %o5	!, tmp109
	or	%o5, 1023, %o5	! tmp109,, tmp108
	cmp	%g1, %o5	! __priority, tmp108
	bne	.LL17	!
	nop
	ld	[%fp+68], %g1	! __initialize_p, __initialize_p
	cmp	%g1, 1	! __initialize_p,
	bne	.LL17	!
	nop
	sethi	%hi(_ZSt8__ioinit), %g1	!, tmp111
	or	%g1, %lo(_ZSt8__ioinit), %o0	! tmp111,,
	call	_ZNSt8ios_base4InitC1Ev, 0
	 nop	!,
.LL17:
	ld	[%fp+72], %g1	! __priority, __priority
	sethi	%hi(64512), %o5	!, tmp114
	or	%o5, 1023, %o5	! tmp114,, tmp113
	cmp	%g1, %o5	! __priority, tmp113
	bne	.LL16	!
	nop
	ld	[%fp+68], %g1	! __initialize_p, __initialize_p
	cmp	%g1, 0	! __initialize_p,
	bne	.LL16	!
	nop
	sethi	%hi(_ZSt8__ioinit), %g1	!, tmp116
	or	%g1, %lo(_ZSt8__ioinit), %o0	! tmp116,,
	call	_ZNSt8ios_base4InitD1Ev, 0
	 nop	!,
.LL16:
	nop
	ret
	restore
.LLFE1407:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.align 4
	.type	_GLOBAL__I_main, #function
	.proc	020
_GLOBAL__I_main:
.LLFB1408:
	!#PROLOGUE# 0
	save	%sp, -112, %sp
.LLCFI4:
	!#PROLOGUE# 1
	mov	1, %o0	!,
	sethi	%hi(64512), %g1	!, tmp107
	or	%g1, 1023, %o1	! tmp107,,
	call	_Z41__static_initialization_and_destruction_0ii, 0
	 nop	!,
	nop
	ret
	restore
.LLFE1408:
	.size	_GLOBAL__I_main, .-_GLOBAL__I_main
	.section	".ctors",#alloc,#write
	.align 4
	.long	_GLOBAL__I_main
	.section	".text"
	.align 4
	.type	_GLOBAL__D_main, #function
	.proc	020
_GLOBAL__D_main:
.LLFB1409:
	!#PROLOGUE# 0
	save	%sp, -112, %sp
.LLCFI5:
	!#PROLOGUE# 1
	mov	0, %o0	!,
	sethi	%hi(64512), %g1	!, tmp107
	or	%g1, 1023, %o1	! tmp107,,
	call	_Z41__static_initialization_and_destruction_0ii, 0
	 nop	!,
	nop
	ret
	restore
.LLFE1409:
	.size	_GLOBAL__D_main, .-_GLOBAL__D_main
	.section	".dtors",#alloc,#write
	.align 4
	.long	_GLOBAL__D_main
	.weak	pthread_mutex_unlock
	.weak	pthread_mutex_trylock
	.weak	pthread_mutex_lock
	.weak	pthread_create
	.weak	pthread_setspecific
	.weak	pthread_getspecific
	.weak	pthread_key_delete
	.weak	pthread_key_create
	.weak	pthread_once
	.section	".eh_frame",#alloc,#write
.LLframe1:
	.uaword	.LLECIE1-.LLSCIE1
.LLSCIE1:
	.uaword	0x0
	.byte	0x1
	.asciz	"zP"
	.byte	0x1
	.byte	0x7c
	.byte	0xf
	.byte	0x8
	.byte	0x50
	.align 4
	.long	__gxx_personality_v0
	.byte	0xc
	.byte	0xe
	.byte	0x0
	.align 4
.LLECIE1:
.LLSFDE1:
	.uaword	.LLEFDE1-.LLASFDE1
.LLASFDE1:
	.uaword	.LLASFDE1-.LLframe1
	.uaword	.LLFB1319
	.uaword	.LLFE1319-.LLFB1319
	.byte	0x0
	.byte	0x4
	.uaword	.LLCFI0-.LLFB1319
	.byte	0xd
	.byte	0x1e
	.byte	0x2d
	.byte	0x9
	.byte	0xf
	.byte	0x1f
	.align 4
.LLEFDE1:
.LLSFDE7:
	.uaword	.LLEFDE7-.LLASFDE7
.LLASFDE7:
	.uaword	.LLASFDE7-.LLframe1
	.uaword	.LLFB1407
	.uaword	.LLFE1407-.LLFB1407
	.byte	0x0
	.byte	0x4
	.uaword	.LLCFI3-.LLFB1407
	.byte	0xd
	.byte	0x1e
	.byte	0x2d
	.byte	0x9
	.byte	0xf
	.byte	0x1f
	.align 4
.LLEFDE7:
.LLSFDE9:
	.uaword	.LLEFDE9-.LLASFDE9
.LLASFDE9:
	.uaword	.LLASFDE9-.LLframe1
	.uaword	.LLFB1408
	.uaword	.LLFE1408-.LLFB1408
	.byte	0x0
	.byte	0x4
	.uaword	.LLCFI4-.LLFB1408
	.byte	0xd
	.byte	0x1e
	.byte	0x2d
	.byte	0x9
	.byte	0xf
	.byte	0x1f
	.align 4
.LLEFDE9:
.LLSFDE11:
	.uaword	.LLEFDE11-.LLASFDE11
.LLASFDE11:
	.uaword	.LLASFDE11-.LLframe1
	.uaword	.LLFB1409
	.uaword	.LLFE1409-.LLFB1409
	.byte	0x0
	.byte	0x4
	.uaword	.LLCFI5-.LLFB1409
	.byte	0xd
	.byte	0x1e
	.byte	0x2d
	.byte	0x9
	.byte	0xf
	.byte	0x1f
	.align 4
.LLEFDE11:
	.ident	"GCC: (GNU) 3.4.2"
