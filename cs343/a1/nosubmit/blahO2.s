	.file	"a1q1.C"
! GNU C++ version 3.4.2 (sparc-sun-solaris2.8)
!	compiled by GNU C version 3.4.2.
! GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
! options passed:  -iprefix -mcpu=v7 -auxbase-strip -O2 -fverbose-asm
! options enabled:  -feliminate-unused-debug-types -fdefer-pop
! -fomit-frame-pointer -foptimize-sibling-calls -funit-at-a-time
! -fcse-follow-jumps -fcse-skip-blocks -fexpensive-optimizations
! -fthread-jumps -fstrength-reduce -fpeephole -fforce-mem -ffunction-cse
! -fkeep-static-consts -fcaller-saves -fpcc-struct-return -fdelayed-branch
! -fgcse -fgcse-lm -fgcse-sm -fgcse-las -floop-optimize -fcrossjumping
! -fif-conversion -fif-conversion2 -frerun-cse-after-loop -frerun-loop-opt
! -fdelete-null-pointer-checks -fschedule-insns -fschedule-insns2
! -fsched-interblock -fsched-spec -fsched-stalled-insns
! -fsched-stalled-insns-dep -fbranch-count-reg -freorder-blocks
! -freorder-functions -fcprop-registers -fcommon -fverbose-asm -fregmove
! -foptimize-register-move -fargument-alias -fstrict-aliasing
! -fmerge-constants -fzero-initialized-in-bss -fident -fpeephole2
! -fguess-branch-probability -fmath-errno -ftrapping-math -mcpu=v7

	.section	".ctors",#alloc,#write
	.align 4
	.long	_GLOBAL__I_main
	.section	".dtors",#alloc,#write
	.align 4
	.long	_GLOBAL__D_main
	.local	_ZSt8__ioinit
	.common	_ZSt8__ioinit,1,1
	.global .rem
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
.LLFB1400:
	!#PROLOGUE# 0
	save	%sp, -152, %sp
.LLCFI0:
	!#PROLOGUE# 1
	call	_ZdlPv, 0	!,
	mov	0, %o0	!, ip
	sethi	%hi(499712), %g1	!, tmp130
	or	%g1, 287, %l1	! tmp130,, tmp110
	mov	0, %i0	!, i
	add	%fp, -16, %l0	!,, tmp132
.LL5:
	mov	%i0, %o0	! i, i
	call	.rem, 0	!,
	mov	10, %o1	!,
	sll	%o0, 2, %o0	!,, tmp120
	add	%o0, %l0, %o0	! tmp120, tmp132, tmp121
	ld	[%o0-40], %g1	! ip, tmp125
	add	%g1, 1, %g1	! tmp125,, tmp126
	add	%i0, 1, %i0	! i,, i
	cmp	%i0, %l1	! i, tmp110
	ble	.LL5	!
	st	%g1, [%o0-40]	! tmp126, ip
	ret
	restore %g0, 0, %o0	!, <result>
.LLFE1400:
	.size	main, .-main
	.align 4
	.type	_Z41__static_initialization_and_destruction_0ii, #function
	.proc	020
_Z41__static_initialization_and_destruction_0ii:
.LLFB1407:
	!#PROLOGUE# 0
	save	%sp, -112, %sp
.LLCFI1:
	!#PROLOGUE# 1
	sethi	%hi(-65536), %g1	!, tmp110
	xnor	%g1, %i1, %g1	! tmp110, __priority, tmp113
	subcc	%g0, %g1, %g0	! tmp113
	subx	%g0, -1, %i1	! tmp112
	xor	%i0, 1, %g1	! __initialize_p,, tmp116
	subcc	%g0, %g1, %g0	! tmp116
	subx	%g0, -1, %o5	! tmp115
	sethi	%hi(_ZSt8__ioinit), %o0	!, tmp121
	andcc	%i1, %o5, %g0	!, tmp112, tmp115
	bne	.LL12	!
	or	%o0, %lo(_ZSt8__ioinit), %o0	! tmp121,,
	subcc	%g0, %i0, %g0	! __initialize_p
.LL13:
	subx	%g0, -1, %g1	! tmp128
	sethi	%hi(_ZSt8__ioinit), %i0	!, tmp133
	andcc	%i1, %g1, %g0	!, tmp112, tmp128
	be	.LL9	!
	or	%i0, %lo(_ZSt8__ioinit), %i0	! tmp133,,
	call	_ZNSt8ios_base4InitD1Ev, 0	!
	 restore
.LL12:
	call	_ZNSt8ios_base4InitC1Ev, 0
	 nop	!,
	b	.LL13	!
	subcc	%g0, %i0, %g0	! __initialize_p
.LL9:
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
	!#PROLOGUE# 1
	sethi	%hi(64512), %o1	!, tmp107
	or	%o1, 1023, %o1	! tmp107,, tmp25
	sethi	%hi(_Z41__static_initialization_and_destruction_0ii), %g1	!
	jmpl	%g1 + %lo(_Z41__static_initialization_and_destruction_0ii), %g0	!
	mov	1, %o0	!, tmp24
	nop
.LLFE1408:
	.size	_GLOBAL__I_main, .-_GLOBAL__I_main
	.align 4
	.type	_GLOBAL__D_main, #function
	.proc	020
_GLOBAL__D_main:
.LLFB1409:
	!#PROLOGUE# 0
	!#PROLOGUE# 1
	sethi	%hi(64512), %o1	!, tmp107
	or	%o1, 1023, %o1	! tmp107,, tmp25
	sethi	%hi(_Z41__static_initialization_and_destruction_0ii), %g1	!
	jmpl	%g1 + %lo(_Z41__static_initialization_and_destruction_0ii), %g0	!
	mov	0, %o0	!, tmp24
	nop
.LLFE1409:
	.size	_GLOBAL__D_main, .-_GLOBAL__D_main
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
.LLSFDE3:
	.uaword	.LLEFDE3-.LLASFDE3
.LLASFDE3:
	.uaword	.LLASFDE3-.LLframe1
	.uaword	.LLFB1407
	.uaword	.LLFE1407-.LLFB1407
	.byte	0x0
	.byte	0x4
	.uaword	.LLCFI1-.LLFB1407
	.byte	0xd
	.byte	0x1e
	.byte	0x2d
	.byte	0x9
	.byte	0xf
	.byte	0x1f
	.align 4
.LLEFDE3:
.LLSFDE5:
	.uaword	.LLEFDE5-.LLASFDE5
.LLASFDE5:
	.uaword	.LLASFDE5-.LLframe1
	.uaword	.LLFB1408
	.uaword	.LLFE1408-.LLFB1408
	.byte	0x0
	.align 4
.LLEFDE5:
.LLSFDE7:
	.uaword	.LLEFDE7-.LLASFDE7
.LLASFDE7:
	.uaword	.LLASFDE7-.LLframe1
	.uaword	.LLFB1409
	.uaword	.LLFE1409-.LLFB1409
	.byte	0x0
	.align 4
.LLEFDE7:
	.ident	"GCC: (GNU) 3.4.2"
