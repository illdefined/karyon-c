#include <memory>
#include <utility/symbol>

	.section .stack, "wa", @nobits
	.align 16
	.global SYMBOL(stack)
SYMBOL(stack):
	.space PAGE_SIZE
