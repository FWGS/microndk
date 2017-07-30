ARCH_LIBS :=
ARCH_CFLAGS :=
LIBS :=
INCLUDES := $(foreach inc,$(LOCAL_C_INCLUDES),-I$(inc))
OBJ_FILES := $(LOCAL_SRC_FILES)
ifeq ($(LOCAL_MODULE),xash)
OBJ_FILES += $(wildcard $(NANOGL_PATH)/*.cpp)
LIBS += 
INCLUDES += -I$(NANOGL_PATH)/GL
endif
OBJ_FILES := $(OBJ_FILES:.cpp=.o)
OBJ_FILES := $(OBJ_FILES:.c=.o)
MICRONDK_TARGET_CFLAGS := $(ARCH_CFLAGS) $(LOCAL_CFLAGS) $(CFLAGS)

LOCAL_MODULE_FILENAME ?= $(LOCAL_MODULE)
LOCAL_MODULE_FILENAME := $(subst lib,,$(LOCAL_MODULE_FILENAME))
MODULE_FILE := $(LOCAL_MODULE_FILENAME).js
ifeq ($(MODULE_FILE),)
     MODULE_FILE := project.js
endif
%.o : %.c
	$(CC) $(MICRONDK_TARGET_CFLAGS) $(LOCAL_CONLYFLAGS) $(INCLUDES) $(DEFINES) -fPIC -c $< -o $@

%.o : %.cpp
	$(CXX) $(MICRONDK_TARGET_CFLAGS) $(LOCAL_CPPFLAGS) $(INCLUDES) $(DEFINES) -c $< -o $@

LOCAL_LDLIBS := $(filter-out -llog,$(LOCAL_LDLIBS))

$(MODULE_FILE) : $(OBJ_FILES)
#	echo $(OBJ_FILES) $(INCLUDES)
	$(CXX) -O3 --js-opts 1 --llvm-lto 3 -g0 -s INLINING_LIMIT=10 -s ELIMINATE_DUPLICATE_FUNCTIONS=1 -s AGGRESSIVE_VARIABLE_ELIMINATION=1 -s SIDE_MODULE=1 -s WEBSOCKET_URL=\'$(LOCAL_MODULE)\' -s SHELL_FILE=\"$(MICRONDK_DIR)/shell_fakedynamiclib.js\" -s -static-libgcc -static-libstdc++ -o $(MODULE_FILE) $(ARCH_LIBS) $(LDFLAGS) $(OBJ_FILES) $(ARCH_LIBS) $(LIBS) $(LOCAL_LDFLAGS) $(LOCAL_LDLIBS) -Wl,--no-warn-mismatch -Wl,--no-undefined
clean:
	rm -f $(OBJ_FILES)
.PHONY: depend clean list
