#include "equates.h"

@We copy-paste the code from LIBGCC to work around NO$GBA bugs

 .text
 .align
 .pool
 
 global_func __aeabi_ldivmod
 global_func __aeabi_uldivmod

__aeabi_ldivmod:
	cmp	r3, #0
	cmpeq	r2, #0
	bne	0f
	cmp	r1, #0
	cmpeq	r0, #0
	movlt	r1, #-2147483648	@ 0x80000000
	movlt	r0, #0
	mvngt	r1, #-2147483648	@ 0x80000000
	mvngt	r0, #0
	b	__aeabi_ldiv0
0:
	sub	sp, sp, #8
	mov r12,sp
	push	{r12, lr}
	bl	__gnu_ldivmod_helper
	ldr	lr, [sp, #4]
	add	sp, sp, #8
	pop	{r2, r3}
	bx	lr

__aeabi_uldivmod:
	cmp	r3, #0
	cmpeq	r2, #0
	bne	0f
	cmp	r1, #0
	cmpeq	r0, #0
	mvnne	r1, #0
	mvnne	r0, #0
	b	__aeabi_ldiv0
0:
	sub	sp, sp, #8
	mov r12,sp
	push	{r12, lr}
	bl	__gnu_uldivmod_helper
	ldr	lr, [sp, #4]
	add	sp, sp, #8
	pop	{r2, r3}
	bx	lr
