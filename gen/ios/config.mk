CFLAGS_OPT :=  -O3 -ggdb -funsafe-math-optimizations -ftree-vectorize -funsafe-loop-optimizations -finline-limit=1024
CFLAGS_OPT_ARM := -mthumb -mfpu=neon -mcpu=cortex-a9 -pipe -DVECTORIZE_SINCOS -fPIC -DHAVE_EFFICIENT_UNALIGNED_ACCESS
LOCAL_CFLAGS += $(CFLAGS_OPT) $(CFLAGS_OPT_ARM)
