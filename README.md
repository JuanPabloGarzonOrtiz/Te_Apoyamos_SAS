# Te_Apoyamos_SAS
Te_Apoyamos_SAS es una aplicación web desarrollada con Laravel, diseñada para presentar los servicios de una firma de abogados. Permite a los usuarios conocer al equipo legal, consultar servicios disponibles y postularse a puestos. Utiliza PHP, Blade, CSS/JS y una base de datos MySQL para gestionar abogados, servicios, casos y postulaciones.

## Estado del Proyecto
En desarrollo

## Tecnologías Usadas
- PHP 8.3 
- PostGresSQL 
- Apache2 
- Blade & CSS3 
- JavaScript



## Organización del Proyecto

```
Te_Apoyamos_SAS/
│
├── app/                         # Lógica principal de la aplicación
│   ├── Console/                 # Comandos de consola Artisan
│   ├── Exceptions/              # Manejo de excepciones
│   ├── Http/                     # Controladores, middleware y peticiones HTTP
│   │   ├── Controllers/         # Controladores de rutas
│   │   ├── Middleware/          # Filtros de peticiones
│   │   └── Kernel.php           # Registro de middleware
│   ├── Models/                  # Modelos Eloquent (Base de datos)
│   └── Providers/               # Proveedores de servicios
│
├── bootstrap/                   # Arranque y carga del framework
│   └── app.php                   # Configuración inicial de Laravel
│
├── config/                      # Archivos de configuración
│
├── database/                    # Migraciones y seeders
│   ├── migrations/              # Scripts para estructura de la BD
│   └── seeders/                  # Poblado inicial de datos
│
├── public/                      # Punto de entrada público (index.php)
│   ├── index.php                 # Arranque de la aplicación
│   └── build/                    # Archivos compilados de frontend
│       ├── js/                   # Archivos JavaScript compilados
│       ├── css/                  # Archivos CSS compilados
│       └── assets/               # Recursos estáticos
│           ├── fonts/            # Tipografías
│           ├── img/              # Imágenes
│           └── svg/              # Archivos SVG
│
├── resources/                   # Recursos sin compilar
│   └── views/                    # Vistas Blade
│
├── routes/                      # Definición de rutas
│   ├── console.php               # Rutas de consola
│   └── web.php                   # Rutas web
│
├── storage/                     # Archivos generados y logs
│   ├── app/                      # Archivos privados y públicos
│   │   ├── private/              # Datos privados
│   │   └── public/               # Datos públicos
│   │       └── hojas_de_vida/    # HV de los encuestados
│   ├── framework/                # Archivos de caché y sesiones
│   └── logs/                     # Archivos de log
│
├── vendor/                      # Dependencias de Composer
│
├── .env                         # Variables de entorno
├── artisan                      # CLI de Laravel
├── composer.json                # Dependencias de PHP
├── composer.lock                # Versiones bloqueadas de dependencias PHP
├── package.json                  # Dependencias de Node.js
├── package-lock.json             # Versiones bloqueadas de dependencias Node.js
├── Dockerfile                    # Configuración para despliegue rápido
└── README.md                    # Documentación del proyecto


```