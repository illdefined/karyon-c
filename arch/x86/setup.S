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

fault:
	/* Cause a triple fault */
	lidt PHYSICAL(SYMBOL(emptyIDT))
	int $0

loop:
	hlt
	jmp loop

entry64:
