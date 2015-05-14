#! /bin/bash

if [ $# -ne 2 ]; then
    echo "Specify parent path for VTK and the desired name of the project (no spaces)."
    echo " example (if you want VTK at /home/vtk/): $0 /home projectname"
else

    if [ -d "$1/vtk/src" ]; then
        echo "VTK already exists, updating instead ..."
        (cd "$1/vtk/src" && git pull)
    else
        echo "Downloading VTK into $1/vtk/src/ ..."
        (cd $1 && mkdir vtk && mkdir vtk/bin && git clone https://gitlab.kitware.com/vtk/vtk.git vtk/src)
    fi

    echo "Building VTK into $1/vtk/bin/ (with Python wrappings and Qt support) ..."
    (cd $1/vtk/bin && cmake ../src -DVTK_WRAP_PYTHON=ON -DBUILD_SHARED_LIBS=ON -DVTK_Group_Qt=ON && make -j4)

    VTK_DIR="$1/vtk/bin"

    echo ${VTK_DIR}

    # make sure the build directory exists
    if [ ! -d "build" ]; then
        echo "Creating build directory ..."
        mkdir build
    fi

    echo "Naming the project ..."
    sed -i "" "s/PROJECT (projectname)/PROJECT ($2)/g" CMakeLists.txt

    echo "Building and running project ..."
    (cd build && cmake .. -DVTK_DIR="${VTK_DIR}") && make -j4 && ./bin/$2
fi
