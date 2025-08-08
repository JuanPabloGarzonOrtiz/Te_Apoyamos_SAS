<?php
    namespace App\Http\Controllers;
    use Illuminate\Http\Request;
    use App\Services\DatabaseService;
    class PostulationController{
        public function savePostulation(Request $request){
            if ($request->hasFile('fileHV')){
                $name = $request->nombre;
                $tel = $request->telefono;
                $email = $request->email;
                $hv = $request->file('fileHV');
                $date = "2025-04-28";
                $hvPath = $hv->store('hojas_de_vida', 'public'); //Guardado de la HV en storage/app/public/hojas_de_vida/
                $dbService = new DatabaseService();
                $dbService->registerApplicant($name, $tel, $email, $date, $hvPath);
                return redirect('/');
            }return dd($request->file('fileHV'));
        }
    }
?>