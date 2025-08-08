<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat</title>
        <script type="module" src="build/js/app.js"></script>
        <link rel="stylesheet" href="build/css/style.css">
        <link rel="stylesheet" href="build/css/style-main.css">
    </head>
    <body class="body-chat">
        <header>
            <img class="logo"  id="imagenDinamica" src="build/assets/img/logo.png">
            <img class="menu-desplegable" src="build/assets/svg/menu-desplegable.svg">
            <nav>
                <a id="ln_inicio" href="/#welcome">Inicio</a>
                <a id="ln_servicios" href="/#areas_de_Practica">Servicios</a>
                <a id="ln_abogados" href="/#abogados"></a>
                <a id="ln_nosotros" href="/#nosotros">Nosotros</a>
                <a id="ln_contacto" href="/chat">Contacto</a>
                <a id="ln_hv" href="/#postulaciones"></a>
            </nav>
        </header>
        <main class="main-chat">
            <input class="input-chat" type="text" placeholder="Escribiele un mensaje a nuestro Asistente">
            <div class="svg-send" id="svg-send">
                <p>Envio</p>
            </div>
        </main>
    </body>
</html>