<?php
    namespace App\Services; //Se usa para definirlo en el espacio de nombres y evita que haya mas de un archivo  con el mismo nobmre. 
    use Illuminate\Support\Facades\DB;

    class DatabaseService{
        public function servicesDB(){
            return DB::select("SELECT 
                                    nombre_Area_Practica, descripción, especialidad 
                                FROM Especialidades_Juridicas;");
        }
        public function abogadosDB(){
            return DB::select("SELECT 
                                    nombre_Abogado, rol_Abogado, titulo_Profesional, nombre_Area_Practica  
                                FROM Abogados a
                                INNER JOIN Especialidades_Juridicas ej ON a.id_Especialidad = ej.id_Especialidad;" );
        }
        public function loginDB($email, $contraseña){
            return DB::select("SELECT nombre_Abogado FROM Abogados WHERE correo = ? AND contraseña = ?;", [$email, $contraseña]);
        }
        public function info_CasosDB($nombre){
            return DB::select("SELECT * FROM info_Casos WHERE nombre_Abogado = ?;", [$nombre,]);
        }
        public function registerApplicant($name, $tel, $email, $date, $path){
            DB::insert("INSERT INTO Solicitudes_Aspirantes (nombre_Aspirante, telefono, correo_Electronico, fecha_Envio_Solicitud, estado_Solicitud, ruta_HV) 
                            VALUES (?,?,?,?,?,?);",[$name, $tel, $email, $date, 'Pendiente', $path]);
        }
    }
?>