@echo off
echo [setup] Running setup scripts...

:: Run get-cmake.bat
echo [setup] Getting CMAKE...
call scripts\get-cmake.bat
if errorlevel 1 (
    echo [setup] Failed to run get-cmake.bat
    exit /b 1
)

:: Compile SDL3
echo [setup] Compiling SDL3...
call scripts\build-sdl3.bat
if errorlevel 1 (
    echo [setup] Failed to run build-sdl3.bat
    exit /b 1
)


:: Run build-vssln.bat
echo [setup] Creating Visual Studio projects...

Vendor\premake\windows\premake5.exe --file=premake5.lua vs2022

echo [setup] All scripts completed successfully.


pause