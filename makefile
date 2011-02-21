CC       ?= clang
CPP      ?= $(CC) -E
SPARSE   ?= sparse -Wbitwise

CPPFLAGS := -nostdinc -Iarch/$(ARCH)/include -Iinclude -ftabstop=4
CFLAGS   := -pipe -ffreestanding -Wall -O2 -fno-common
LDFLAGS  := -nostdlib -static

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

karyon: .depend
	$(SPARSE) $(CPPFLAGS) $(karyon)
	$(CROSS)$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $(karyon) $(LDFLAGS)

.depend: $(karyon)
	$(CROSS)$(CPP) $(CPPFLAGS) -M -MT karyon $(karyon) >$@

clean:
	rm -f .depend karyon

.PHONY: clean
.SUFFIXES:

.include "arch/$(ARCH)/makefile"
