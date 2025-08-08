<?php
    use Illuminate\Support\Facades\Route;
    use App\Services\DatabaseService;
    use App\Http\Controllers\PostulationController;
    use App\Http\Controllers\VerifyEmailController;

    Route::get('/', function () {
        $dbService = new DatabaseService();
        $especialidades = (new DatabaseService())-> servicesDB();
        $abogados = $dbService->abogadosDB();
        return view('index', ["especialidades" => $especialidades],["abogados" =>$abogados]);
    });

    Route::get('/service', function(){
        $data = (new DatabaseService())-> servicesDB();
        return view("info_Service", ["especialidades" => $data]);
    });

    Route::get('/chat', function(){
        return view('chat');
    });

    Route::get('/postulacion', function(){
        return view('form_Postulacion');
    });
    Route::post("postulacion", [PostulationController::class, 'savePostulation'])->name('form.postulation');

    Route::get("/login", function(){
        return view("login");
    })->name('login');
    Route::post("login", [VerifyEmailController::class, 'login']);

    Route::get("/dashboard", function(){
        return view("dashboard");
    })->name('dashboard')
?>