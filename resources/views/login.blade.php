<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="build/css/style-internalProcess.css"> 
    </head>
    <body class="body-login">
        <form method="POST" action="{{ route('login') }}" enctype="multipart/form-data">
            @csrf
            <h1>Usuario</h1>
            <hr>
            <input type="text" name="email">
            <h1>Contraseña</h1>
            <hr>
            <input type="password" name="password">
            <button type="submit" style="color:white;">Ingresar</button>
        </form>
    </body>
</html>