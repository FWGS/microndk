LIBS :=
INCLUDES := $(foreach inc,$(LOCAL_C_INCLUDES),-I$(inc))
OBJ_FILES := $(LOCAL_SRC_FILES)
ifeq ($(LOCAL_MODULE),xash)
OBJ_FILES += $(wildcard $(NANOGL_PATH)/*.cpp)
LIBS += libSDL2.so -lm
INCLUDES += -I$(NANOGL_PATH)/GL
endif
OBJ_FILES := $(OBJ_FILES:.cpp=.o)
OBJ_FILES := $(OBJ_FILES:.c=.o)
CFLAGS := -I$(MICRONDK_DIR) -D_NDK_MATH_NO_SOFTFP=1 -mhard-float -mfloat-abi=hard -D__ANDROID__ $(LOCAL_CFLAGS)

LOCAL_MODULE_FILENAME ?= $(LOCAL_MODULE)
LOCAL_MODULE_FILENAME := $(subst lib,,$(LOCAL_MODULE_FILENAME))
MODULE_FILE := lib$(LOCAL_MODULE_FILENAME:.so=).so

%.o : %.c
	$(CC) $(CFLAGS) $(LOCAL_CONLYFLAGS) $(INCLUDES) $(DEFINES) -fPIC -c $< -o $@

%.o : %.cpp
	$(CXX) $(CFLAGS) $(INCLUDES) $(DEFINES) -fPIC -c $< -o $@

$(MODULE_FILE) : $(OBJ_FILES)
#	echo $(OBJ_FILES) $(INCLUDES)
	g++ -o $(MODULE_FILE) -shared $(MICRONDK_DIR)/libm_hard.a $(OBJ_FILES) $(MICRONDK_DIR)/libm_hard.a $(LIBS) -Wl,--no-warn-mismatch -Wl,--no-undefined -lstdc++ -llog -Wl,-soname=$(MODULE_FILE)
clean:
	$(RM) $(OBJ_FILES)
.PHONY: depend clean list