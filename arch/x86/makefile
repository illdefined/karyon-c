.if $(CC) == clang || $(CC) == gcc
CFLAGS += -m64 -mrtd -mcld -msahf -mregparm=3 -mno-red-zone -mcmodel=kernel
.endif

karyon += arch/x86/stack.S
