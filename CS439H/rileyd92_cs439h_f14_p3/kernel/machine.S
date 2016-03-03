#define ASSEMBLY
#include "gdt.h"

	# contextSwitch(long* currentESP, long nextESP)
        .global contextSwitch
contextSwitch:
        mov 4(%esp),%eax     // *currentESP
        mov 8(%esp),%ecx     // nextESP

	cmp $0,%eax
	jz activateNext

        pushf
        push %ebx
        push %esi
        push %edi
        push %ebp

        mov %esp,(%eax)

activateNext:
        mov %ecx,%esp

        pop %ebp
        pop %edi
        pop %esi
        pop %ebx
        popf

        ret

	# uint32_t fetchAndAdd32(uint32_t* ptr, uint32_t v)
	.global fetchAndAdd32
fetchAndAdd32:
	mov 4(%esp),%ecx		# ptr
	mov 8(%esp),%eax		# ptr
	lock xaddl %eax,(%ecx)
	ret

        # eflags
        .global eflags
eflags:
	pushf
	pop %eax
	ret

	# outb(int port, int val)
	.global outb
outb:
	push %edx
	mov 8(%esp),%dx
	mov 12(%esp),%al
	outb %al,%dx
	pop %edx
	ret

	# int inb(int port)
	.global inb
inb:
	push %edx
	mov 8(%esp),%dx
	inb %dx,%al
	pop %edx
	and $0xff,%eax
	ret

	# unsigned long inb(int port)
	.global inl
inl:
	push %edx
	mov 8(%esp),%dx
	inl %dx,%eax
	pop %edx
	ret


	#
	# void ltr(uint32_t tr)
	#
	.global ltr
ltr:
	mov 4(%esp),%eax
	ltr %ax
	ret

	/* vmm_on(pd) */
	.global vmm_on
vmm_on:
	mov 4(%esp),%eax
	mov %eax,%cr3

	mov %cr0,%eax
	or $0x80000000,%eax
	mov %eax,%cr0
	ret
	
	.global getcr0
getcr0:
	mov %cr0,%eax
	ret
	
	.global getcr3
getcr3:
	mov %cr3,%eax
	ret

	.global invlpg
invlpg:
	mov 4(%esp),%eax
	invlpg (%eax)
	ret

	.global cli
cli:
	cli
	ret

	.global sti
sti:
	sti
	ret

# PIT

	/* pit_init(divide) */
	.global pit_do_init
pit_do_init:
	pushf			# push IF
	cli			# disable interrupts
	movb $0b00110100,%al	# 00 (channel 0)
				# 110 (lobyte/hibyte)
				# 100 (rate generator)
	outb %al,$0x43		# write command
	movb 8(%esp),%al	# divide
        outb %al,$0x40
	movb 9(%esp),%al
	outb %al,$0x40
	popf			# pop IF
	ret
