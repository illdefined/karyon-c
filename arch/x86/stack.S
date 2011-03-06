#include <memory>
#include <utility/symbol>

	.section .stack, "wa", @nobits
	.align WORD_SIZE
	.global SYMBOL(stack)
SYMBOL(stack):
	.space PAGE_SIZE
