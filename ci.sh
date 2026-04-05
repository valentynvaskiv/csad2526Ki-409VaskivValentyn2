#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "CI build script — run from repository root"

# Create build directory if missing and enter it
mkdir -p build
cd build || { echo "Failed to enter build directory" >&2; exit 1; }

# Configure the project using CMake
echo "Configuring with CMake..."
cmake .. || { echo "CMake configuration failed." >&2; exit 1; }

# Build the project
echo "Building..."
cmake --build . || { echo "Build failed." >&2; exit 1; }

# Ensure execution rights for build.sh if present (repo root or build directory)
if [ -f ../build.sh ]; then
  chmod +x ../build.sh && echo "Made ../build.sh executable"
fi
if [ -f ./build.sh ]; then
  chmod +x ./build.sh && echo "Made build.sh executable"
fi

# Run tests via CTest (show failures)
echo "Running tests..."
ctest --output-on-failure || { echo "Some tests failed." >&2; exit 1; }

echo "CI script completed successfully."
exit 0