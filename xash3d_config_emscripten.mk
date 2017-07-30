TARGET_ARCH_ABI = emscripten
CFLAGS_OPT := -Os -funsafe-math-optimizations -fstrict-aliasing -fomit-frame-pointer --llvm-lto 3 -g0 -s INLINING_LIMIT=10
LOCAL_CFLAGS += $(CFLAGS_OPT)
