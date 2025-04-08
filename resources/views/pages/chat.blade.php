<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat</title>
        @vite(['resources/js/app.js'])
        @vite(['resources/css/style.css'])
        @vite(['resources/css/style-main.css'])
    </head>
    <body class="body-chat">
        <header class="header">
            <img class="logo"  id="imagenDinamica" src="/images/logo.png" alt="logo">
            <svg class="menu-desplegable" tabindex="0" viewBox="0 -960 960 960">
                <path d="M120-240v-80h720v80H120Zm0-200v-80h720v80H120Zm0-200v-80h720v80H120Z"/>
            </svg>
            <nav class="nav">
                <a id="ln_inicio" href="/">Inicio</a>
                <a id="ln_servicios" href="/#areas_de_Practica">Servicios</a>
                <a id="ln_abogados" href="/#abogados"></a>
                <a id="ln_nosotros" href="/#nosotros">Nosotros</a>
                <a id="ln_contacto" href="{{ route('chat') }}">Contacto</a>
                <a id="ln_hv" href="/#postulaciones"></a>
            </nav>
        </header>
        <main class="main-chat">
            <div class="background-input">
                <input  type="text" placeholder="Escribiele un mensaje a nuestro Asistente">
                <button>
                    <svg width="60" height="60" viewBox="-4 4 88 70" fill="none">
                        <path d="M69.333,74.000L10.667,74.000L40.000,10.667L69.333,74.000ZZM58.333,67.333L40.000,27.833L21.667,67.333L34.500,67.333L40.000,47.333L45.500,67.333L58.333,67.333ZZM58.333,67.333L21.667,67.333L58.333,67.333ZZ" style="fill: rgb(0, 0, 0); fill-opacity: 1;" class="fills"/>
                    </svg>
                </button>
            </div>
        </main>
    </body>
</html>
