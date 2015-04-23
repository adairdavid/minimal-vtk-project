if [$# -ne 2]; then
    echo "You must pass the desired install directory as an argument. ex: /home/"
else
    echo Downloading VTK into $1/vtk/src/ ...
    (cd $1 && mkdir vtk && mkdir vtk/bin && git clone https://gitlab.kitware.com/vtk/vtk.git vtk/src)

    echo Building VTK into $1/vtk/bin/ ...
    (cd $1/vtk/bin && cmake ../src && make -j12)

    echo "Building project and running program ..."
    ./configure && (cd build && cmake .. -DVTK_DIR="$1/vtk/bin") && make && ./bin/projectname
fi
