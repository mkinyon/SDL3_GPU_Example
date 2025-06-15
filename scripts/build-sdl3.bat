@echo off
setlocal

:: Set paths
set CMAKE_EXE=vendor\cmake\bin\cmake.exe
set SDL3_SOURCE_DIR=vendor\SDL3
set SDL3_BUILD_DIR=vendor\SDL3\build

:: Optional: create the build directory if it doesn't exist
if not exist "%SDL3_BUILD_DIR%" (
    mkdir "%SDL3_BUILD_DIR%"
)

:: Step 1: Generate build files with CMake
echo Generating SDL3 build system...
"%CMAKE_EXE%" -S "%SDL3_SOURCE_DIR%" -B "%SDL3_BUILD_DIR%" -G "Visual Studio 17 2022" -A x64 -DBUILD_SHARED_LIBS=ON

:: Step 2: Build SDL3 (Debug & Release)
echo Building SDL3 (Debug)...
"%CMAKE_EXE%" --build "%SDL3_BUILD_DIR%" --config Debug

echo Building SDL3 (Release)...
"%CMAKE_EXE%" --build "%SDL3_BUILD_DIR%" --config Release

