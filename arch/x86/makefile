.if $(CC) == clang || $(CC) == gcc
CFLAGS += -m64 -mcld -msahf -mno-red-zone -mcmodel=kernel
.endif

karyon += \
	arch/x86/emptyIDT.c \
	arch/x86/entry.S \
	arch/x86/multiboot.S \
	arch/x86/setup.S \
	arch/x86/stack.S
