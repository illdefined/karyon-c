#include <memory>
#include <utility/symbol>

OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
OUTPUT_ARCH(i386:x86-64)
ENTRY(SYMBOL(entry))

PHDRS {
	multiboot PT_NOTE FLAGS(0);
	text      PT_LOAD FLAGS(5);
	rodata    PT_LOAD FLAGS(4);
	data      PT_LOAD FLAGS(6);
}

SECTIONS {
	.multiboot : {
		*(.multiboot)
	} :multiboot

	. = VIRTUAL_BASE + SIZEOF_HEADERS;

	.text ALIGN(PAGE_SIZE) :
	AT(ADDR(.text) - VIRTUAL_BASE) {
		*(.text)
	} :text =0x90909090

	.stack ALIGN(PAGE_SIZE) :
	AT(ADDR(.stack) - VIRTUAL_BASE) {
		*(.stack)
	} :data

	.rodata ALIGN(PAGE_SIZE) :
	AT(ADDR(.rodata) - VIRTUAL_BASE) {
		*(.rodata)
	} :rodata

	.data ALIGN(PAGE_SIZE) :
	AT(ADDR(.data) - VIRTUAL_BASE) {
		*(.data)
	} :data

	.bss ALIGN(WORD_SIZE):
	AT(ADDR(.bss) - VIRTUAL_BASE) {
		*(.bss)
	} :data
}

PROVIDE(SYMBOL(text_head) = LOADADDR(.text));
PROVIDE(SYMBOL(text_size) = SIZEOF(.text));
PROVIDE(SYMBOL(text_tail) = SYMBOL(text_head) + SYMBOL(text_size));

PROVIDE(SYMBOL(stack_head) = LOADADDR(.stack));
PROVIDE(SYMBOL(stack_size) = SIZEOF(.stack));
PROVIDE(SYMBOL(stack_tail) = SYMBOL(stack_head) + SYMBOL(stack_size));

PROVIDE(SYMBOL(rodata_head) = LOADADDR(.rodata));
PROVIDE(SYMBOL(rodata_size) = SIZEOF(.rodata));
PROVIDE(SYMBOL(rodata_tail) = SYMBOL(rodata_head) + SYMBOL(rodata_size));

PROVIDE(SYMBOL(bss_head) = LOADADDR(.bss));
PROVIDE(SYMBOL(bss_size) = SIZEOF(.bss));
PROVIDE(SYMBOL(bss_tail) = SYMBOL(bss_head) + SYMBOL(bss_size));

PROVIDE(SYMBOL(text_page) = ALIGN(SYMBOL(text_head), PAGE_SIZE) / PAGE_SIZE);
PROVIDE(SYMBOL(text_pges) = ALIGN(SYMBOL(text_size), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(SYMBOL(stack_page) = ALIGN(SYMBOL(stack_head), PAGE_SIZE) / PAGE_SIZE);
PROVIDE(SYMBOL(stack_pges) = ALIGN(SYMBOL(stack_size), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(SYMBOL(rodata_page) = ALIGN(SYMBOL(rodata_head), PAGE_SIZE) / PAGE_SIZE);
PROVIDE(SYMBOL(rodata_pges) = ALIGN(SYMBOL(rodata_size), PAGE_SIZE) / PAGE_SIZE);

PROVIDE(SYMBOL(data_page) = ALIGN(SYMBOL(data_head), PAGE_SIZE) / PAGE_SIZE);
PROVIDE(SYMBOL(data_pges) = ALIGN(SYMBOL(bss_tail) - SYMBOL(data_head)) / PAGE_SIZE);
