<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Postulaciones</title>
        <link rel="stylesheet" href="/build/assets/style.css">
        <link rel="stylesheet" href="/build/assets/style-main.css">
        <script src="/build/assets/app.js"></script>
    </head>
    <body class="formulario">
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
        <main class="mainform">
            <div class="separador_Form"></div>
            <form  class="formPostulation" method="POST" action="{{ route('form.postulation') }}" enctype="multipart/form-data">
                @csrf
                <h1>Ingrese sus Datos</h1>
                <div>
                    <h2>Nombre:</h2>
                    <input name="nombre" type="text" required="" placeholder="Nombre..">
                </div>
                <div>
                    <h2>Telefono:</h2>
                    <input name="telefono" type="tel" required="" pattern="[0-9]+" minlength="10" maxlength="10" placeholder="Tel..">
                </div>
                <div>
                    <h2>Correo:</h2>
                    <input name="email" type="email" required="" placeholder="xxxx@mail.com">
                </div>
                <div class="HV">
                    <h2>Hoja de Vida:</h2>
                    <input name="fileHV"  id="fileHV" type="file" required="" accept=".pdf">
                    <label for="fileHV">Sube tu Hoja de Vida</label>
                </div>
                <button type="submit">Enviar</button>
            </form>
        </main>
    </body>
</html>