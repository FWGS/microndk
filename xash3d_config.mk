TARGET_ARCH_ABI = native
CFLAGS_OPT := -O3 -funsafe-math-optimizations -ftree-vectorize -fgraphite-identity -floop-interchange -funsafe-loop-optimizations -finline-limit=1024
CFLAGS_GCC := -ggdb -g -fno-omit-frame-pointer

ifeq ($(AMD64),1)
ifneq ($(64BIT),1)
CFLAGS += -m32
LDFLAGS += -m32
endif
endif
LOCAL_CFLAGS += $(CFLAGS_OPT) $(CFLAGS_GCC)
