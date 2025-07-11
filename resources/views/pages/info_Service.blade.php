<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Info_Service</title>
    <link rel="stylesheet" href="/build/assets/style.css">
    <link rel="stylesheet" href="/build/assets/style-main.css">
    <script src="/build/assets/app.js"></script>
</head>
    <body>
        <header>
            <img class="logo"  id="imagenDinamica" src="/images/logo.png" alt="logo">
            <svg class="menu-desplegable" tabindex="0" viewBox="0 -960 960 960" >
                <path d="M120-240v-80h720v80H120Zm0-200v-80h720v80H120Zm0-200v-80h720v80H120Z"/>
            </svg>
            <nav class="nav">
                <a id="ln_inicio" href="/#welcome">Inicio</a>
                <a id="ln_servicios" href="/#areas_de_Practica">Servicios</a>
                <a id="ln_abogados" href="/#abogados"></a>
                <a id="ln_nosotros" href="/#nosotros">Nosotros</a>
                <a id="ln_contacto" href="/chat">Contacto</a>
                <a id="ln_hv" href="/#postulaciones"></a>
            </nav>
        </header>
        <main class="service_only">
            <section class="servicio">
                @php
                    $datosDecodificados = json_decode(base64_decode($_GET['data']), true);
                    echo "<h1>{$datosDecodificados['nombre']}</h1>";
                    echo "<p>{$datosDecodificados['descripcion']}</p>";
                @endphp
                <div>
                    <button>Solitiar Aseoria</button>
                </div>
            </section>
            <section class="areas_de_Practica">
                <h1>Otras Asesoria</h1>
                <div class="otros_Servicios">
                    @foreach ($especialidades as $especialidad)
                        @php
                            $datos = json_encode([
                                'nombre' => $especialidad->nombre_area_practica,
                                'descripcion' => $especialidad->descripción
                            ]);
                        @endphp
                        <a href="/service?data={{ base64_encode($datos) }}">
                            <div class="otros_servicios" data-nombre="{{ $especialidad->nombre_area_practica }}">
                                <div class="svg-container"></div>
                                <p>{{ $especialidad->nombre_area_practica }}</p>
                            </div>
                        </a>
                    @endforeach
                </div>
            </section>
        </main>
    </body>
</html>