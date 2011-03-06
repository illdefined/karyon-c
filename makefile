CC       ?= clang
CPP      ?= $(CC) -E
SPARSE   ?= sparse -Wbitwise

CPPFLAGS := -nostdinc -Iarch/$(ARCH)/include -Iinclude -ftabstop=4
CFLAGS   := -pipe -ffreestanding -Wall -O2 -fno-common
LDFLAGS  := -nostdlib -static -Wl,-T karyon.ld

.if !defined(ARCH)
.	if $(MACHINE) == i386 || $(MACHINE) == x86_64
ARCH     := x86
.	endif
.endif

.if $(CC) == clang || $(CC) == gcc
CPPFLAGS += -std=c99
CFLAGS   += -fmerge-all-constants -fstrict-overflow -fwhole-program -freg-struct-return -fshort-enums
.endif

.if $(CC) == gcc
CFLAGS   += -combine
.endif

ldS := arch/$(ARCH)/karyon.ld.S

karyon: .depend karyon.ld
	$(SPARSE) $(CPPFLAGS) $(karyon:M*.c)
	$(CROSS)$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $(karyon) $(LDFLAGS)

karyon.ld: .depend
	$(CROSS)$(CPP) $(CPPFLAGS) -P -o $@ $(ldS)

.depend: $(ldS) $(karyon)
	$(CROSS)$(CPP) $(CPPFLAGS) -M -MT karyon.ld $(ldS) >$@
	$(CROSS)$(CPP) $(CPPFLAGS) -M -MT karyon $(karyon) >>$@

clean:
	rm -f .depend karyon.ld karyon

.PHONY: clean
.SUFFIXES:

.include "arch/$(ARCH)/makefile"
