CC ?= gcc

ifeq ($(CC),cc)
    CC := gcc
endif
my-dir := $(shell pwd)
PROJECT_DIR ?= $(shell pwd)
MICRONDK_DIR ?= $(dir $(lastword $(MAKEFILE_LIST)))

SYS := $(shell $(CC) -dumpmachine)
ifneq (, $(findstring linux, $(SYS)))
MICRONDK_OS := linux
endif
ifneq (, $(findstring android, $(SYS)))
MICRONDK_OS := android
endif
ifneq (, $(findstring mingw, $(SYS)))
MICRONDK_OS := mingw
PROJECT_DIR := .
my-dir := .
override LOCAL_PATH=.
endif

CLEAR_VARS := $(MICRONDK_DIR)/clear_vars.mk
XASH3D_CONFIG := $(MICRONDK_DIR)/xash3d_config.mk
ifeq ($(MICRONDK_OS),mingw)
      BUILD_SHARED_LIBRARY := $(MICRONDK_DIR)/build-shared-mingw.mk
else
    BUILD_SHARED_LIBRARY := $(MICRONDK_DIR)/build-shared.mk
endif

ifeq ($(MICRONDK_OS),android)
    XASH3D_CONFIG := $(MICRONDK_DIR)/xash3d_config_android.mk
endif

ifneq ($(GENERATE),)
    BUILD_SHARED_LIBRARY := $(MICRONDK_DIR)/build-shared-gen.mk
    XASH3D_CONFIG := $(MICRONDK_DIR)/gen/$(GENERATE)/config.mk
endif

NANOGL_PATH=../nanogl
SDL_PATH=../SDL2
XASH_SDL=0
include $(PROJECT_DIR)/Android.mk
