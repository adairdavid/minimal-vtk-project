#include "vtkCylinderSource.h"
#include "vtkPolyDataMapper.h"
#include "vtkActor.h"
#include "vtkRenderer.h"
#include "vtkRenderWindow.h"
#include "vtkRenderWindowInteractor.h"
#include "vtkProperty.h"
#include "vtkSmartPointer.h"
#include "vtkCamera.h"

int main(int argc, char *argv[]) {
    vtkSmartPointer<vtkCylinderSource> cylinder =
        vtkSmartPointer<vtkCylinderSource>::New();
    cylinder->SetResolution(8);

    vtkSmartPointer<vtkPolyDataMapper> mapper =
        vtkSmartPointer<vtkPolyDataMapper>::New();
    mapper->SetInputConnection(cylinder->GetOutputPort());

    vtkSmartPointer<vtkActor> actor =
        vtkSmartPointer<vtkActor>::New();
    actor->SetMapper(mapper);
    actor->GetProperty()->SetColor(1.0000, 0.3882, 0.2784);
    actor->RotateX(30.0);
    actor->RotateY(-45.0);

    vtkSmartPointer<vtkRenderer> renderer =
        vtkSmartPointer<vtkRenderer>::New();

    vtkSmartPointer<vtkRenderWindow> window =
        vtkSmartPointer<vtkRenderWindow>::New();

    window->AddRenderer(renderer);

    vtkSmartPointer<vtkRenderWindowInteractor> interactor =
        vtkSmartPointer<vtkRenderWindowInteractor>::New();
    interactor->SetRenderWindow(window);

    renderer->AddActor(actor);
    renderer->SetBackground(0.1, 0.2, 0.4);
    window->SetSize(400, 400);

    renderer->ResetCamera();
    window->Render();

    interactor->Start();

    return 0;
}
