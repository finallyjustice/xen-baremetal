XEN_SRC = /home/zhang/os/mainline-xen

#ARCH dependent
XEN_TARGET_ARCH = x86_64
ifeq ($(XEN_TARGET_ARCH),x86_32)
ARCH_CFLAGS   := -m32 -march=i686
ARCH_LDFLAGS  := -m elf_i386 -T x86_32.lds
ARCH_ASFLAGS  := -m32
ARCH_OBJS     := bootstrap.x86_32.o
endif
ifeq ($(XEN_TARGET_ARCH),x86_64)
ARCH_CFLAGS   := -m64
ARCH_ASFLAGS  := -m64
ARCH_LDFLAGS  := -m elf_x86_64 -T x86_64.lds
ARCH_OBJS     := bootstrap.x86_64.o
endif

CPPFLAGS += -I$(XEN_SRC)/xen/include/public $(ARCH_CPPFLAGS)
LDFLAGS  += -nostdlib $(ARCH_LDFLAGS)
CFLAGS   += -Wall -Werror -std=c99 $(ARCH_CFLAGS)
ASFLAGS   = -D__ASSEMBLY__ $(ARCH_ASFLAGS)

.PHONY: all clean

all: minios.bin

minios.bin: $(ARCH_OBJS) kernel.o
	$(LD) $(LDFLAGS) $^ -o minios.bin

clean:
	rm -f *.o
	rm -f minios.bin
