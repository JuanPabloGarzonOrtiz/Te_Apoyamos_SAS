<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Casos Asignados</title>
        <link rel="stylesheet" href="build/css/style-internalProcess.css"> 
        @php
            $data = session('cursorCasos')
        @endphp
    </head>
    <body>
        <section class="section-data">
            <img class="logo-casos" src="build/assets/img/logo.png" alt="">
            <div>
                <p><dfn>Nombre: </dfn>{{ $data[0]->nombre_abogado }}</p>
                <p><dfn>Titulo Profesional: </dfn>{{$data[0]->titulo_profesional}}</p>
                <p><dfn>Puesto Asignado: </dfn>{{$data[0]->rol_abogado}}</p>
            </div>
            <img  class="photo_Abogado" src="build/assets/img/foto_Abogado.jpg" alt="">
        </section>
        <section class="section-table">
            <table>
                <thead>
                    <th>#</th>
                    <th>ID de Caso</th>
                    <th>Demandante</th>
                    <th>Demandado</th>
                    <th>Tipo de Caso</th>
                    <th>Estado</th>
                    <th>Fecha de Inicio</th>
                    <th>Fecha de Fin</th>
                </thead>
                @for ($i=0; $i< count($data); $i++)
                    <tbody>
                        <tr>
                            <td>{{$i +1}}</td>
                            <td>{{$data[$i]->ID_de_Caso}}</td>
                            <th>{{$data[$i]->demandante}}</th>
                            <th>{{$data[$i]->demandado}}</th>
                            <th>{{$data[$i]->tipo_de_Caso}}</th>
                            <th>{{$data[$i]->estado}}</th>
                            <th>{{$data[$i]->fecha_de_Inicio}}</th>
                            <th>{{$data[$i]->fecha_de_Fin}}</th>
                        </tr>
                    </tbody>
                @endfor
            </table>
        </section>
    </body>
</html>