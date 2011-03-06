.if $(CC) == clang || $(CC) == gcc
CFLAGS += -m64 -mcld -msahf -mno-red-zone -mcmodel=kernel
.endif

karyon += arch/x86/stack.S
