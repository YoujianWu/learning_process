# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kook/CMakeCatkinTutorials/Example_06_Install

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kook/CMakeCatkinTutorials/cmake-build

# Include any dependencies generated for this target.
include CMakeFiles/example6.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/example6.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/example6.dir/flags.make

CMakeFiles/example6.dir/src/main.cpp.o: CMakeFiles/example6.dir/flags.make
CMakeFiles/example6.dir/src/main.cpp.o: /home/kook/CMakeCatkinTutorials/Example_06_Install/src/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kook/CMakeCatkinTutorials/cmake-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/example6.dir/src/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/example6.dir/src/main.cpp.o -c /home/kook/CMakeCatkinTutorials/Example_06_Install/src/main.cpp

CMakeFiles/example6.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/example6.dir/src/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/kook/CMakeCatkinTutorials/Example_06_Install/src/main.cpp > CMakeFiles/example6.dir/src/main.cpp.i

CMakeFiles/example6.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/example6.dir/src/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/kook/CMakeCatkinTutorials/Example_06_Install/src/main.cpp -o CMakeFiles/example6.dir/src/main.cpp.s

# Object files for target example6
example6_OBJECTS = \
"CMakeFiles/example6.dir/src/main.cpp.o"

# External object files for target example6
example6_EXTERNAL_OBJECTS =

example6: CMakeFiles/example6.dir/src/main.cpp.o
example6: CMakeFiles/example6.dir/build.make
example6: liblibmyCode.a
example6: CMakeFiles/example6.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/kook/CMakeCatkinTutorials/cmake-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable example6"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/example6.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/example6.dir/build: example6

.PHONY : CMakeFiles/example6.dir/build

CMakeFiles/example6.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/example6.dir/cmake_clean.cmake
.PHONY : CMakeFiles/example6.dir/clean

CMakeFiles/example6.dir/depend:
	cd /home/kook/CMakeCatkinTutorials/cmake-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kook/CMakeCatkinTutorials/Example_06_Install /home/kook/CMakeCatkinTutorials/Example_06_Install /home/kook/CMakeCatkinTutorials/cmake-build /home/kook/CMakeCatkinTutorials/cmake-build /home/kook/CMakeCatkinTutorials/cmake-build/CMakeFiles/example6.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/example6.dir/depend

