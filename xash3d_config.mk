TARGET_ARCH_ABI = native
CFLAGS_OPT := -O3 -funsafe-math-optimizations -ftree-vectorize -fgraphite-identity -floop-interchange -funsafe-loop-optimizations -finline-limit=1024
CFLAGS_GCC := -ggdb -g


LOCAL_CFLAGS += $(CFLAGS_OPT) $(CFLAGS_GCC)
