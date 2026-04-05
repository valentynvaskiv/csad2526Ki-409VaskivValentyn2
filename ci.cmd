@echo off
setlocal enabledelayedexpansion

REM CI build script — run from repository root

REM Create build directory if missing and enter it
if not exist "build" (
    mkdir "build"
)
cd /d "build" || (echo Failed to enter build directory & exit /b 1)

REM Configure the project using CMake
cmake ..
if errorlevel 1 (
    echo CMake configuration failed.
    exit /b 1
)

REM Build the project
cmake --build .
if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

REM Run tests via CTest (show failures)
ctest --output-on-failure
if errorlevel 1 (
    echo Some tests failed.
    exit /b 1
)

echo CI script completed successfully.
exit /b 0