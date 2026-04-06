cmake_minimum_required(VERSION 3.20)

project(Lab1 VERSION 1.0 LANGUAGES CXX)

# ========== Compiler settings ==========
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# (опційно) жорсткіші попередження для MSVC
if (MSVC)
  add_compile_options(/W4 /permissive-)
else()
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# ========== Library ==========
add_library(math_operations STATIC
  math_operations.cpp
)
target_include_directories(math_operations
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
)

# ========== Main executable ==========
add_executable(Lab1
  main.cpp
)
target_link_libraries(Lab1
  PRIVATE math_operations
)

# ========== Tests ==========
option(BUILD_TESTS "Build unit tests" ON)

if(BUILD_TESTS)
  enable_testing()
  include(FetchContent)

  # стабільна версія googletest
  FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.15.2.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  )
  # Для Windows: не міняти CRT налаштування батьківського проєкту
  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  FetchContent_MakeAvailable(googletest)

  add_executable(unit_tests
    tests/unit_tests.cpp   # <-- правильний шлях
  )
  target_link_libraries(unit_tests
    PRIVATE GTest::gtest_main math_operations
  )

  include(GoogleTest)
  gtest_discover_tests(unit_tests)
endif()
