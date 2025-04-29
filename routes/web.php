<?php
    use App\Http\Controllers\Auth\VerifyEmailController;
    use App\Http\Controllers\PostulationController;
    use Illuminate\Support\Facades\Route;
    use App\Services\DatabaseService;

    Route::get('/', function () {
        $dbService = new DatabaseService();
        $especialidades = $dbService->servicesDB();
        $abogados = $dbService->abogadosDB();
        return view('welcome', ["especialidades" => $especialidades],["abogados" =>$abogados]);
    })->name('home');

    Route::get('/chat',function(){
        return view('pages.chat');
    })->name('chat');

    Route::get("/service", function(){
        $data = new DatabaseService() -> servicesDB();
        return view("pages.info_Service", ["especialidades" => $data]);
    })->name("service");

    Route::get("/postulacion", function(){
        return view('pages.form_Postulation');
    })->name("postulacion");

    Route::post("postulacion", [PostulationController::class, 'savePostulation'])->name('form.postulation');

    Route::get("/login", function(){
        return view("livewire.auth.login");
    })->name("login");

    Route::post("login", [VerifyEmailController::class, 'login'])->name('form.login');
    
    Route::get("/dashboard", function(){
        return view("pages.casos_Asignados");
    })->name("dashboard");
?>
