#! /bin/bash

if [ $# -ne 2 ]; then
    echo "Specify parent path for VTK/ITK and the desired name of the project (no spaces)."
    echo " example (if you want VTK at /home/vtk/ and ITK at /home/itk/): $0 /home projectname"
else

    if [ -d "$1/vtk/src" ]; then
        echo "VTK already exists, updating instead ..."
        (cd "$1/vtk/src" && git pull)
    else
        echo "Downloading VTK into $1/vtk/src/ ..."
        (cd $1 && mkdir vtk && mkdir vtk/bin && git clone https://gitlab.kitware.com/vtk/vtk.git vtk/src)
    fi

    if [ -d "$1/itk/src" ]; then
        echo "ITK already exists, updating instead ..."
        (cd "$1/itk/src" && git pull)
    else
        echo "Downloading ITK into $1/itk/src/ ..."
        (cd $1 && mkdir itk && mkdir itk/bin && git clone http://itk.org/ITK.git itk/src)
    fi

    echo "Building VTK into $1/vtk/bin/ (with Python wrappings and Qt support) ..."
    (cd $1/vtk/bin && cmake ../src -DVTK_WRAP_PYTHON=ON -DBUILD_SHARED_LIBS=ON -DVTK_Group_Qt=ON && make -j12)

    echo "Building ITK into $1/itk/bin/ (with Python wrappings) ..."
    (cd $1/itk/bin && cmake ../src -DITK_WRAP_PYTHON=ON -DBUILD_SHARED_LIBS=ON -DVTK_DIR=$1/vtk/bin -DModule_ITKVtkGlue=ON -DITK_LEGACY_SILENT=ON && make -j12)

    VTK_DIR="$1/vtk/bin"
    ITK_DIR="$1/itk/bin"

    echo ${VTK_DIR}
    echo ${ITK_DIR}

    # make sure the build directory exists
    if [ ! -d "build" ]; then
        echo "Creating build directory ..."
        mkdir build
    fi

    echo "Naming the project ..."
    sed -i "" "s/PROJECT (projectname)/PROJECT ($2)/g" CMakeLists.txt

    echo "Building and running project ..."
    (cd build && cmake .. -DVTK_DIR="${VTK_DIR}" -DITK_DIR="${ITK_DIR}") && make -j12 && ./bin/$2
fi
