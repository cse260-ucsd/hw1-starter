ARMPL_DIR = /opt/arm/armpl_22.0.2_gcc-11.2/
INCD := -I${ARMPL_DIR}/include/

# Compiler and flags
MY_OPT := -O3 -mcpu=native -ffast-math
CXX := g++
# CXX := armclang
CXXFLAGS := -Wall -Wextra -std=c++17  $(INCD) -ggdb -O3 $(MY_OPT)

# Target executable name
TARGET := mm

# Source files (all .cpp in current directory and matrix subdirectory)
SRCS := $(wildcard *.cpp) $(wildcard dgemm/*.cpp) $(wildcard matrix/*.cpp) $(wildcard utils/*.cpp) $(wildcard cse260_hw1/*.cpp)

# Object files
OBJS := $(SRCS:.cpp=.o)

LD := g++

LIBD := -L${ARMPL_DIR}/lib/
LDFLAGS := $(LIBD) -larmpl_lp64

# Default rule
all: $(TARGET)


# Explicit link step
$(TARGET): $(OBJS)
	$(LD) -Wl,--no-as-needed -o $@ $^ $(LDFLAGS) -lpthread -lm


# Compile .cpp to .o
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up build artifacts
clean:
	rm -f $(OBJS) $(TARGET) matrix/*.o utils/*.o dgemm/*.o

# Phony targets
.PHONY: all clean
