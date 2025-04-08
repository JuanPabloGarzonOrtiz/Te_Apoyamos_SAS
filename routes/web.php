<?php
    use Illuminate\Support\Facades\Route;
    use Livewire\Volt\Volt;
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

    Route::get("/login", function(){
        return view("livewire.auth.login");
    })->name("service");

    Route::get("/dashboard", function(){
        return view("pages.casos_Asignados");
    })->name("dashboard");

    /*Temporal Route*/
    Route::get("/test-db", function(){
        dd(new DatabaseService()->servicesDB());
    });

    /*
    Route::view('dashboard', 'dashboard')
        ->middleware(['auth', 'verified'])
        ->name('dashboard');

    Route::middleware(['auth'])->group(function () {
        Route::redirect('settings', 'settings/profile');

        Volt::route('settings/profile', 'settings.profile')->name('settings.profile');
        Volt::route('settings/password', 'settings.password')->name('settings.password');
        Volt::route('settings/appearance', 'settings.appearance')->name('settings.appearance');
    });
    require __DIR__.'/auth.php';*/
?>
