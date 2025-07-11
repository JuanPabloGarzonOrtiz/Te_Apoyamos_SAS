# Te_Apoyamos_SAS
Te_Apoyamos_SAS es una plataforma web desarrollada con el framework Laravel, diseñada para representar de manera profesional a una firma de abogados. Su objetivo principal es brindar a los usuarios una experiencia informativa y accesible, permitiéndoles conocer más sobre los servicios legales ofrecidos, el equipo de abogados y las áreas de práctica de la firma.

## Estado del Proyecto
En desarrollo

## Tecnologías Usadas
- PHP 8.4
- PostGreSQL 
- HTML5 & CSS3 
- JavaScript 
- Laravel *(Framework)*


## Organización del Proyecto
```
Te_Apoyamos_SAS/
├── app
│   ├── Http
│   │   ├── ControllersPostulationController.php      # Controlador PHP que maneja las postulaciones de HV.
│   │   └── Auth
│   │       └── VerifyEmailController.php             # Controlador para manejar el login de abogados al Dashboard.
│   └── Service
│       └── DatabaseService.php                       # Servicio para manejar la base de datos.
│
├── database
│   └── sql
│       └── proyectoDB.sql                            # Archivo de creación de la base de datos.
│
├── public
│   ├── fonts/                                         # Fuentes del proyecto.
│   ├── images/                                        # Imágenes del proyecto.
│   └── build
│       └── assents
│           ├── app.js                                # Manejo de dinamismo del header.
│           ├── style-internalProcess.css             # CSS para Dashboard y Login.
│           ├── style-main.css                        # CSS para el main del proyecto.
│           └── style.css                             # CSS reutilizable en varios layouts.
│
├── resources
│   └── views
│       ├── welcome.blade.php                         # Página inicial del proyecto.
│       ├── livewire
│       │   └── auth
│       │       └── login.blade.php                   # Página de login de abogados.
│       └── pages
│           ├── casos_Asginados.blade.php             # Dashboard de casos asignados a abogado.
│           ├── chat.blade.php                        # Chat de información al usuario.
│           ├── form_Postulation.blade.php            # Formulario de postulación a puestos de la firma.
│           └── info_Service.blade.php                # Página de información de cada uno de los servicios de la firma.
│
├── routes
│   ├── auth.php                                     # Rutas relacionadas con autenticación.
│   └── web.php                                      # Rutas web principales del proyecto.
│
├── .env                                            # Archivo de configuración de entorno.
└── index.php                                       # Punto de entrada principal de la aplicación.

```

## Próximos Pasos
- Integrar Asistente de Chat para el usuario.
- Integrar mas vistas de informacion de los Casos para lo Abogados.
