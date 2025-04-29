<?php
    namespace App\Http\Controllers\Auth;
    use Illuminate\Http\Request;
    use App\Services\DatabaseService;

    class VerifyEmailController{
        public function login(Request $request){
            $dbService = new DatabaseService();
            $email = $request->email;
            $contraseña = $request->password;
            $cursorLogin = $dbService->loginDB($email, $contraseña);
            if (!empty($cursorLogin) && isset($cursorLogin[0]->nombre_Abogado)){
                $nombre = $cursorLogin[0]->nombre_Abogado;
                $cursorCasos = $dbService->info_CasosDB($nombre);
                if (!empty($cursorCasos)){
                    session(['cursorCasos' => $cursorCasos]);
                    return redirect()->route('dashboard');
                }
            }return redirect()->route('login');
        }
    }
?>