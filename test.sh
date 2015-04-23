if [ $# -ne 1 ]; then
    echo "Specify parent path for VTK."
    echo " example (if you want VTK at /home/vtk/): $0 /home"
else
    echo "Downloading VTK into $1/vtk/src/ ..."
    (cd $1 && mkdir vtk && mkdir vtk/bin && git clone https://gitlab.kitware.com/vtk/vtk.git vtk/src)

    echo "Building VTK into $1/vtk/bin/ (with Python wrappings) ..."
    (cd $1/vtk/bin && cmake ../src -DVTK_WRAP_PYTHON=ON && make -j12)

    echo "Building project and running program ..."
    VTK_DIR="$1/vtk/bin"
    echo ${VTK_DIR}
    (cd build && cmake .. -DVTK_DIR="${VTK_DIR}") && make -j12 && ./bin/projectname
fi
