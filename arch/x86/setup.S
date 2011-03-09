#include <memory>
#include <multiboot>
#include <utility/symbol>

	.section .setup
	.global SYMBOL(setup)
SYMBOL(setup):

	mov SYMBOL(stack) + PAGE_SIZE, %rsp
