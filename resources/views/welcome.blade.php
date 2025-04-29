<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Analisis de Requerimientos</title>
        <link rel="stylesheet" href="/build/assets/style.css">
        <link rel="stylesheet" href="/build/assets/style-main.css">
        <script src="/build/assets/app.js"></script>
    </head>
    <body>
        <img class="background-welcome" src="/images/background-index.png">
        <header>
            <img class="logo"  id="imagenDinamica" src="/images/logo.png" alt="logo">
            <svg class="menu-desplegable" tabindex="0" viewBox="0 -960 960 960">
                <path d="M120-240v-80h720v80H120Zm0-200v-80h720v80H120Zm0-200v-80h720v80H120Z"/>
            </svg>
            <nav>
                <a id="ln_inicio" href="#welcome">Inicio</a>
                <a id="ln_servicios" href="#areas_de_Practica">Servicios</a>
                <a id="ln_abogados" href="#abogados"></a>
                <a id="ln_nosotros" href="#nosotros">Nosotros</a>
                <a id="ln_contacto" href="/chat">Contacto</a>
                <a id="ln_hv" href="#postulaciones"></a>
            </nav>
        </header>
        <main>
            <section class="welcome" id="welcome">
                <h1>Más que la Civilización, la Justicia es la Necesidad del Pueblo</h1>
                <div class="separador_Welcome"></div>
                <div>
                    <button><a href="/chat">Solicitud de Asesoría</a></button>
                </div>
            </section>
            <section class="areas_de_Practica" id="areas_de_Practica">
                <h1>Asesoria en Practica</h1>
                <div class="servicios_Destacados">
                    @foreach ($especialidades as $especialidad)
                        @if ($especialidad->especialidad == 1)
                            @php
                                $datos = json_encode([
                                    'nombre' => $especialidad->nombre_Area_Practica,
                                    'descripcion' => $especialidad->descripción
                                ]);
                            @endphp
                            <a href="/service?data={{ base64_encode($datos) }}">
                                <div class="especialidad" data-nombre="{{ $especialidad->nombre_Area_Practica }}">
                                    <div class="svg-container"></div>
                                    <p>{{ $especialidad->nombre_Area_Practica }}</p>
                                </div>
                            </a>
                        @endif
                    @endforeach
                </div>
                <div class="otros_Servicios">
                    @foreach ($especialidades as $especialidad)
                            @if ($especialidad->especialidad != 1)
                                @php
                                    $datos = json_encode([
                                        'nombre' => $especialidad->nombre_Area_Practica,
                                        'descripcion' => $especialidad->descripción
                                    ]);
                                @endphp
                                <a href="/service?data={{ base64_encode($datos) }}">
                                    <div class="otros_servicios" data-nombre="{{ $especialidad->nombre_Area_Practica }}">
                                        <div class="svg-container"></div>
                                        <p>{{ $especialidad->nombre_Area_Practica }}</p>
                                    </div>
                                </a>
                            @endif
                    @endforeach
                </div>
            </section>
            <section class="abogados" id="abogados">
                <h2>Fitrar</h2>
                <div class="options_Filtrer">
                    <div>
                        <h3>Nombre:</h3>
                        <input type="text">
                    </div>
                    <div>
                        <h3>Rama:</h3>
                        <input type="text">
                    </div>
                </div>
                @php
                    $especialidades = array_column($abogados, 'nombre_Area_Practica');
                    $especialidades_Filtradas = array_unique($especialidades);
                @endphp
                @foreach ($especialidades_Filtradas as $especialidad)
                    <h1>{{$especialidad}}</h1>
                    <div class="div-abogados">
                        @foreach ($abogados as $abogado)
                            @if ($abogado->nombre_Area_Practica == $especialidad)
                                <div class="abogado">
                                    <img src="/images/foto_Abogado.jpg" alt="">
                                    <p>{{$abogado->nombre_Abogado}}</p>
                                    <p>{{$abogado->titulo_Profesional}}</p>
                                </div>
                            @endif
                        @endforeach
                    </div>
                @endforeach
            </section>
            <section class="nosotros" id="nosotros">
                <h1 >Nosotros</h1>
                <p>La firma de Abogadso "Te Apoyamos SAS", esta conformada por un equipo de profesionales disponibles para brindar asesoria legal y apoyo en la toma de desiciones en entornos profesionales donde el marco legal es un referente para el desarrollo y desemepño correcto de una organización</p>
                <h1>Fundadores</h1>
                <div class="div-abogados">
                    @foreach ($abogados as $abogado)
                        @if ($abogado->rol_Abogado == "Fundador")
                            <div class="abogado">
                                <img src="/images/foto_Abogado.jpg" alt="">
                                <p>{{$abogado->nombre_Abogado}}</p>
                                <p>{{$abogado->titulo_Profesional}}</p>
                            </div>
                        @endif
                    @endforeach
                </div>
                <h1 >Historia</h1>
                <p>La firma de Abogadso "Te Apoyamos SAS", esta conformada por un equipo de profesionales disponibles para brindar asesoria legal y apoyo en la toma de desiciones en entornos profesionales donde el marco legal es un referente para el desarrollo y desemepño correcto de una organización</p>
            </section>
            <section class="postulaciones" id="postulaciones">
                <h1 class="title_postulacion">Haz Parte de Nuestra Firma de Abogados</h1>
                <button><a href="/postulacion">Hoja de Vida</a></button>
            </section>
        </main>
    </body>
</html>