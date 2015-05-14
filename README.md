README
======

This is a minimal project template that should build and run out of
the box, that includes automated testing using Google Test. For any
small project, all you need to do is change __src/main.cpp__, and add
any new files (__.cc__ and __.h__) in __src/__. To test these new
files/functions, change the __test_SRCS__ list in
__test/CMakeLists.txt__ (line 14) and add a new file in
__tests/__. See __test/sanity_check.cc__ for an example of writing a
test.

To get up and running, run the install script:

    sh install-script.sh desired/vtk/install/path desiredprojectname

The script will install VTK at the specified path, and will
generate an executable with the desired project name. It will
automatically run the application to verify the installation worked
(opens a VTK renderer with a cylinder).

For example, if you specify *~/Developer* as the install path for
VTK, you will get the following:

    ~/Developer/vtk
    ~/Developer/vtk/src/
    ~/Developer/vtk/bin/

And your current project will target the */bin/* directories for the
shared libraries. The */src/* directories contain the git repository
for the respective library. If you run the install script again (and
provide the same path) the script will attempt to update the
repository, rather than downloading the complete system.

From then on, anytime you want to run your application, do the
following:

    ./configure
    make -j4
    ./bin/projectname

where projectname is the specified desiredprojectname, above.

__please note that the build will fail if the tests fail__

To change the name of the executable, change the __PROJECT(..)__ (line
7) target in __CMakeLists.txt__.
