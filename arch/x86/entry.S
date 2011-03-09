#include <memory>
#include <multiboot>
#include <utility/symbol>

	.section .setup
	.global SYMBOL(entry)
SYMBOL(entry):
	.code32

	/* Check for boot loader magic */
	cmp $MULTIBOOT_LOADER_MAGIC, %eax
	jne fault

	/* TODO: Set page table up */

	/* Enable PAE and PGE */
	mov %cr4, %eax
	or  $1 << 5 | 1 << 7, %eax
	mov %eax, %cr4

	/* Enable long mode */
	mov $0xC0000080, %ecx
	rdmsr
	bts $8, %eax
	wrmsr

	/* Enable paging */
	mov %cr0, %eax
	bts $31, %eax
	mov %eax, %cr0

	/* TODO: Jump to 64bit entry */

fault:
	/* Cause a triple fault */
	lidt PHYSICAL(SYMBOL(emptyIDT))
	int $0

loop:
	hlt
	jmp loop
