#!/bin/bash

# ########################################################
# Function to display usage information
# ########################################################
usage() {
    echo "Usage: $0 <project_name>"
    exit 1
}

# ########################################################
# Check for at least one argument
# ########################################################
if [ $# -lt 1 ]; then
    usage
fi

# ########################################################
# Parse arguments
# ########################################################
PROJECT_NAME=$1

# ########################################################
# Create project directory and subdirectories
# ########################################################
mkdir -p "$PROJECT_NAME"/{lib,src}
cd "$PROJECT_NAME"

echo "Creating directories"


# ########################################################
# Create main.c with basic program structure
# ########################################################
echo "#include <stdio.h>
#include \"../lib/lib_1.h\"

int main(void) {

    return 0;
}" > src/main.c
echo "src/main.c file created"


# ########################################################
# Create lib_1.h with a basic structure
# ########################################################
echo "// lib_1.h - Header file for your C library
#ifndef LIB_1_H
#define LIB_1_H

// Include standard headers or other libraries here
#include <stdio.h>

// Function declarations
void exampleFunction();

#endif // LIB_1_H" > lib/lib_1.h

echo "lib/lib_1.h file created"


# ########################################################
# Create CMakeLists.txt
# ########################################################
echo "cmake_minimum_required(VERSION 3.7)
project(${PROJECT_NAME})

# Set the C Compiler
set(CMAKE_C_COMPILER clang)

# Specify the C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# Include directories
include_directories(lib)

# Add the source files
file(GLOB SOURCES \"src/*.c\")

# Add the executable
add_executable(main.exe \${SOURCES})

# Find clang-format
find_program(CLANG_FORMAT \"clang-format\")
if(CLANG_FORMAT)
    # Add a custom target to format the source files
    add_custom_target(
        format
        COMMAND \${CLANG_FORMAT} -i -style=file \${SOURCES}
        COMMENT \"Running clang-format on source files\"
    )
endif()
" > CMakeLists.txt
echo "CMakeLists.txt file created"

# ########################################################
# Create run.sh to build and run the program using CMake
# ########################################################
echo "#!/bin/bash
mkdir -p build
cd build
cmake ..
make
./main.exe" > run.sh
echo "run.sh script created"

chmod +x run.sh

echo "C project setup complete in $PROJECT_NAME"

