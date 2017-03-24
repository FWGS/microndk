ARCH_LIBS :=
ARCH_CFLAGS :=
LIBS := -lstdc++ -ldl
INCLUDES := $(foreach inc,$(LOCAL_C_INCLUDES),-I$(inc))
OBJ_FILES := $(LOCAL_SRC_FILES)
ifeq ($(LOCAL_MODULE),xash)
OBJ_FILES += $(wildcard $(NANOGL_PATH)/*.cpp)
LIBS += -llog
ifeq ($()XASH_SDL),1)
LIBS += libSDL.so
endif
INCLUDES += -I$(NANOGL_PATH)/GL
endif
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a-hard)
    ARCH_CFLAGS += -I$(MICRONDK_DIR)/android-hardfp -D_NDK_MATH_NO_SOFTFP=1 -mhard-float -mfloat-abi=hard
    ARCH_LIBS += $(MICRONDK_DIR)/android-hardfp/libm_hard.a
else
    ARCH_LIBS += -lm
endif
OBJ_FILES := $(OBJ_FILES:.cpp=.o)
OBJ_FILES := $(OBJ_FILES:.c=.o)
MICRONDK_TARGET_CFLAGS := $(ARCH_CFLAGS) $(LOCAL_CFLAGS) $(CFLAGS)

LOCAL_MODULE_FILENAME ?= $(LOCAL_MODULE)
LOCAL_MODULE_FILENAME := $(subst lib,,$(LOCAL_MODULE_FILENAME))
MODULE_FILE := lib$(LOCAL_MODULE_FILENAME:.so=).so

%.o : %.c
	$(CC) $(MICRONDK_TARGET_CFLAGS) $(LOCAL_CONLYFLAGS) $(INCLUDES) $(DEFINES) -fPIC -c $< -o $@

%.o : %.cpp
	$(CXX) $(MICRONDK_TARGET_CFLAGS) $(LOCAL_CPPFLAGS) $(INCLUDES) $(DEFINES) -fPIC -c $< -o $@

LOCAL_LDLIBS := $(filter-out -llog,$(LOCAL_LDLIBS))

$(MODULE_FILE) : $(OBJ_FILES)
#	echo $(OBJ_FILES) $(INCLUDES)
	$(CXX) -lstdc++ -o $(MODULE_FILE) -shared  $(LIBS) $(LOCAL_CPPFLAGS) $(ARCH_LIBS) $(LDFLAGS) $(LOCAL_LDFLAGS) $(OBJ_FILES) $(LOCAL_LDLIBS) $(ARCH_LIBS) -Wl,--no-warn-mismatch -Wl,--no-undefined -Wl,-soname=$(MODULE_FILE) -lstdc++
clean:
	$(RM) $(OBJ_FILES)
.PHONY: depend clean list
