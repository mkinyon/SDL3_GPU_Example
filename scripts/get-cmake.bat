@echo off
setlocal

set CMAKE_VERSION=4.0.3
set CMAKE_ZIP=cmake-%CMAKE_VERSION%-windows-x86_64.zip
set CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v%CMAKE_VERSION%/%CMAKE_ZIP%
set DOWNLOAD_PATH=%~dp0%CMAME_ZIP%
set TEMP_DIR=vendor\cmake-tmp
set TARGET_DIR=vendor\cmake

::--- if we already have cmake.exe, skip ---
if exist "vendor\cmake\bin\cmake.exe" (
  echo [setup-cmake] CMake already downloaded, skipping.
  exit /b 0
)

echo [get-cmake] Downloading CMake %CMAKE_VERSION%...
curl -L -o %CMAKE_ZIP% %CMAKE_URL%

echo [get-cmake] Extracting to temp folder...
powershell -Command "Expand-Archive -Path '%CMAKE_ZIP%' -DestinationPath '%TEMP_DIR%' -Force"

echo [get-cmake] Moving contents to %TARGET_DIR%...
if not exist %TARGET_DIR% mkdir %TARGET_DIR%
xcopy /E /I /Y "%TEMP_DIR%\cmake-%CMAKE_VERSION%-windows-x86_64\*" "%TARGET_DIR%\"

echo [get-cmake] Cleaning up...
rmdir /S /Q "%TEMP_DIR%"
del "%CMAKE_ZIP%"

echo [get-cmake] Done. CMake is available in %TARGET_DIR%\bin\cmake.exe

endlocal