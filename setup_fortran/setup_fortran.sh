#!/bin/bash

# Displaying usage information
usage() {
    echo "Usage: $0 <project_name>"
    exit 1
}

# Check for at least one argument
if [ $# -lt 1 ]; then
    usage
fi

# Parse arguments
PROJECT_NAME=$1

# Create project directory and subdirectories
mkdir -p "$PROJECT_NAME"/{lib,src}
cd "$PROJECT_NAME"

# Create main.f90 with basic program structure
echo "program main
    implicit none

    ! Your main program code goes here

end program main" > src/main.f90

# Create lib_1.f90 with a basic module
# echo "module lib_1
#     implicit none
#
#     ! Your module code goes here
#
# end module lib_1" > lib/lib_1.f90

# Create a basic Makefile
echo "# Compiler and flags
FC = gfortran
FFLAGS = -Wall -Wextra -g

# Directories
SRCDIR = src
LIBDIR = lib
OBJDIR = obj

# Source and object files
SRCS = \$(wildcard \$(SRCDIR)/*.f90) \$(wildcard \$(LIBDIR)/*.f90)
OBJS = \$(SRCS:%.f90=\$(OBJDIR)/%.o)

# Executable name
EXEC = main

# Default rule
all: \$(EXEC)

# Rule for creating the executable
\$(EXEC): \$(OBJS)
	\$(FC) \$(FFLAGS) -o \$@ \$^

# Rule for creating object files
\$(OBJDIR)/%.o: %.f90
	@mkdir -p \$(@D)
	\$(FC) \$(FFLAGS) -c \$< -o \$@

# Clean rule
clean:
	rm -rf \$(OBJDIR) \$(EXEC)

# Phony targets
.PHONY: all clean" > Makefile

# Create run.sh to compile and run the program
echo "#!/bin/bash
make clean
make
./main" > run.sh

chmod +x run.sh

echo "Fortran project setup complete in $PROJECT_NAME"

