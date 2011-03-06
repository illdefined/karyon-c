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

	.bss ALIGN(PAGE_SIZE):
	AT(ADDR(.bss) - VIRTUAL_BASE) {
		*(.bss)
	} :data
}

PROVIDE(SYMBOL(text_addr) = LOADADDR(.text));
PROVIDE(SYMBOL(text_size) = SIZEOF(.text));

PROVIDE(SYMBOL(stack_addr) = LOADADDR(.stack));
PROVIDE(SYMBOL(stack_size) = SIZEOF(.stack));

PROVIDE(SYMBOL(rodata_addr) = LOADADDR(.rodata));
PROVIDE(SYMBOL(rodata_size) = SIZEOF(.rodata));

PROVIDE(SYMBOL(bss_addr) = LOADADDR(.bss));
PROVIDE(SYMBOL(bss_size) = SIZEOF(.bss));
