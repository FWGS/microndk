TARGET_ARCH_ABI = emscripten
CFLAGS_OPT := -Os -funsafe-math-optimizations -funsafe-loop-optimizations -finline-limit=30 -fstrict-aliasing -fomit-frame-pointer
LOCAL_CFLAGS += $(CFLAGS_OPT)
