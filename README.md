# MICRONDK
Microndk is makefile collection for building native xash3d project with standalone toolchain and omit hardfloat problems.
Useful on android with cctools.

To build, change current directory to directory with Android.mk (with module defination) and run:
```
make -f /path/to/Microndk.mk
```
Add `-j5` if you have 4 cores.

### Currently supported platforms:
* Android (You may build mods and engine)
* Windows (MinGW)
* Linux
* iOS Xcode project generator
* Any platform that use gcc + gmake and have unix shell utilities

## Android
### CCTools
You may build on android natively with cctools toolchain. Install gcc, libstdc++-compact and make packages

It is recommended to use https://github.com/FWGS/xash3d-android-tools-sysroot (removes `libgnustl_shared.so` dependency)

To set sysroot, specify `SYSROOT_DIR=/path/to/xash3d-android-tools-sysroot`

To use STLport, specify `STLPORT_DIR=/path/to/xash3d-android-tools-stlport`

### Termux

Use gcc_termux package to install gcc: https://github.com/its-pointless/gcc_termux

Next is similar to cctools method, but

You *MUST* use sysroot from https://github.com/FWGS/xash3d-android-tools-sysroot , or it will generate dangerous binaries

### Separate toolchain

Use this toolchain https://github.com/FWGS/xash3d-android-tools-toolchain
Other toolchains are not tested, but you may try and report to issues

# Windows
Install MinGW (non-pthread version), set enviroment

Edit xash3d-config.mk if needed

cd to directory contains Android.mk

run `mingw32-make -f \path\to\microndk\Microndk.mk`

if you are using 64-bit mingw-w64 version, specify CC="gcc -m32" CXX="g++ -m32"

# Linux

Edit xash3d-config.mk if needed

cd to directory contains Android.mk

run `mingw32-make -f /path/to/microndk/Microndk.mk`

if you are using 64-bit system, specify CC="gcc -m32" CXX="g++ -m32"
