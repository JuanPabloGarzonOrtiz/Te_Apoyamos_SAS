<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    @vite(['resources/css/style-internalProcess.css'])
</head>
<body class="body-login">
    <form method="GET" action="" enctype="multipart/form-data">
        <h1>Usuario</h1>
        <hr>
        <input type="text">
        <h1>Contraseña</h1>
        <hr>
        <input type="password">
        <button>
            <a  class="button" href="{{ route('dashboard') }}">Ingresar</a>
        </button>
    </form>
</body>
</html>