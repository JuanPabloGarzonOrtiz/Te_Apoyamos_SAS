CREATE DATABASE Te_Apoyamos_SAS_DB;
USE Te_Apoyamos_SAS_DB;

/*Tablas*/
CREATE TABLE Especialidades_Juridicas(
	id_Especialidad INTEGER PRIMARY KEY AUTO_INCREMENT,
	nombre_Area_Practica VARCHAR(50) UNIQUE NOT NULL,
	descripción TEXT NOT NULL,
	ambito_de_Aplicación JSON NOT NULL,
    especialidad TINYINT(1) NOT NULL
);
CREATE TABLE Abogados(
	id_Abogado INTEGER PRIMARY KEY AUTO_INCREMENT,
	nombre_Abogado VARCHAR(50) NOT NULL,
	rol_Abogado VARCHAR(20) NOT NULL,
	contraseña VARCHAR(255) NOT NULL,
	titulo_Profesional VARCHAR(100) NOT NULL,
	titulo_Especialización VARCHAR(100) NOT NULL,
	registro_Colegio_Abogados VARCHAR(20) UNIQUE NOT NULL,
	cedula_de_Ciudadania VARCHAR(10) UNIQUE NOT NULL,
	telefono VARCHAR(15) UNIQUE NOT NULL,
	correo VARCHAR(255) UNIQUE NOT NULL,
	idiomas JSON DEFAULT '{Español}' NOT NULL,
	id_Especialidad INTEGER NOT NULL,
	FOREIGN KEY(id_Especialidad) REFERENCES Especialidades_Juridicas(id_Especialidad)
);
CREATE TABLE Casos_Legales(
	id_Caso INTEGER PRIMARY KEY AUTO_INCREMENT,
	estado_de_Caso ENUM('Activo','Pausado','Archivado','Culminado') DEFAULT 'Activo' NOT NULL,
	descripción TEXT NOT NULL,
	fecha_Inicio DATE NOT NULL,
	fecha_Fin DATE NOT NULL,
	id_Especialidad INTEGER NOT NULL,
	FOREIGN KEY(id_Especialidad) REFERENCES Especialidades_Juridicas(id_Especialidad)
);
CREATE TABLE Abogados_Casos(
	id_Abogado INTEGER NOT NULL,
	id_Caso INTEGER NOT NULL,
	FOREIGN KEY(id_Abogado) REFERENCES Abogados(id_Abogado),
	FOREIGN KEY(id_Caso) REFERENCES Casos_Legales(id_Caso)
);
CREATE TABLE Clientes(
	id_Cliente INTEGER PRIMARY KEY AUTO_INCREMENT,
	nombre_Cliente VARCHAR(50) NOT NULL,
	cedula_de_Ciudadanía VARCHAR(10) UNIQUE NOT NULL,
	telefono VARCHAR(15) UNIQUE NOT NULL,
	correo_Electronico VARCHAR(255) UNIQUE NOT NULL,
	tipo_de_Participación ENUM('Demandado','Demandante','Testigo','Denunciante','Denunciado','Tercer Interveniente','Victima','Afectado','Beneficiario','Fiador') NOT NULL
);
CREATE TABLE Clientes_Casos(
	id_Cliente INTEGER NOT NULL,
	id_Caso INTEGER NOT NULL,
	FOREIGN KEY(id_Cliente) REFERENCES Clientes(id_Cliente),
	FOREIGN KEY(id_Caso) REFERENCES Casos_Legales(id_Caso)
);
CREATE TABLE Solicitudes_Aspirantes(
	id_Aspirante INTEGER PRIMARY KEY AUTO_INCREMENT,
	nombre_Aspirante VARCHAR(50) NOT NULL,
	telefono VARCHAR(10) UNIQUE NOT NULL,
	correo_Electronico VARCHAR(255) UNIQUE NOT NULL,
	fecha_Envio_Solicitud DATE NOT NULL,
	estado_Solicitud ENUM('Pendiente','Rechazada', 'Aceptada') NOT NULL,
	ruta_HV TEXT UNIQUE NOT NULL
);

/*Valores*/
INSERT INTO Especialidades_Juridicas(nombre_Area_Practica, descripción, ambito_de_Aplicación, especialidad)
	VALUES
		('Derecho Penal',
		'Rama del derecho que regula la potestad punitiva del Estado, estableciendo normas para la prevención y sanción de delitos, así como las garantías procesales de los imputados.',
		'{"jurisdicción": "Nacional","tipo_de_casos": ["Delitos menores", "Delitos graves", "Crimen organizado", "Homicidios", "Estafas y fraudes", "Violencia de género"],"instituciones_relacionadas": ["Fiscalía", "Tribunales Penales", "Defensoría Pública", "Policía", "Cárceles y centros penitenciarios"],"leyes_aplicables": ["Código Penal", "Código Procesal Penal", "Leyes contra la delincuencia organizada"]}',
		0),
		('Derecho Civil', 
		'Regula las relaciones jurídicas entre particulares en aspectos patrimoniales y personales, incluyendo contratos, propiedad, sucesiones y responsabilidad civil.',
		'{"jurisdicción": "Nacional","tipo_de_casos": ["Contratos", "Responsabilidad civil", "Propiedad y posesión", "Familia y sucesiones", "Obligaciones y deudas"],"instituciones_relacionadas": ["Juzgados Civiles", "Notarías", "Registros de la Propiedad", "Defensoría del Consumidor"],"leyes_aplicables": ["Código Civil", "Código de Comercio", "Ley de Propiedad", "Normativa de contratos y obligaciones"]}',
		0),
		('Derecho Mercantil',
		'Disciplina que regula las relaciones jurídicas derivadas de los actos de comercio, así como la constitución, funcionamiento y disolución de sociedades mercantiles.',
		'{"jurisdicción": "Nacional e Internacional","tipo_de_casos": ["Contratos comerciales", "Sociedades mercantiles", "Banca y seguros", "Propiedad industrial", "Insolvencia y quiebras"],"instituciones_relacionadas": ["Juzgados Mercantiles", "Registro de Comercio", "Superintendencia de Sociedades", "Bolsa de Valores"],"leyes_aplicables": ["Código de Comercio", "Ley de Sociedades", "Regulación Bancaria", "Normativa de Propiedad Intelectual"]}',
		1),
		('Derecho Laboral',
		'Regula las relaciones entre empleadores y trabajadores, estableciendo derechos, obligaciones y mecanismos de solución de conflictos laborales.',
		'{"jurisdicción": "Nacional","tipo_de_casos": ["Despidos injustificados", "Acoso laboral", "Negociaciones colectivas", "Condiciones de trabajo", "Seguridad social"],"instituciones_relacionadas": ["Juzgados de lo Laboral", "Ministerio de Trabajo", "Sindicatos", "Seguridad Social"],"leyes_aplicables": ["Código de Trabajo", "Ley de Seguridad Social", "Normativa de Salud Ocupacional", "Convenios de la OIT"]}',
		0),
		('Derecho Constitucional',
		'Rama del derecho encargada del estudio, interpretación y aplicación de los principios y normas contenidas en la Constitución de un Estado.',
		'{"jurisdicción": "Nacional","tipo_de_casos": ["Derechos fundamentales", "Acciones de inconstitucionalidad", "Amparos", "Control de constitucionalidad", "Relaciones entre poderes del Estado"],"instituciones_relacionadas": ["Corte Constitucional", "Tribunales Supremos", "Defensoría del Pueblo", "Congreso o Parlamento"],"leyes_aplicables": ["Constitución", "Leyes Orgánicas", "Tratados Internacionales de Derechos Humanos", "Jurisprudencia Constitucional"]}',
		0),
		('Derecho Administrativo',
		'Regula la organización y funcionamiento del Estado y su relación con los ciudadanos, garantizando la legalidad en los actos de la Administración Pública.',
		'{"jurisdicción": "Nacional","tipo_de_casos": ["Actos administrativos", "Contratación pública", "Responsabilidad del Estado", "Recursos administrativos", "Funcionamiento de entidades públicas"],"instituciones_relacionadas": ["Tribunales Administrativos", "Ministerios y Secretarías de Estado", "Contraloría General", "Defensoría del Pueblo"],"leyes_aplicables": ["Ley de Procedimiento Administrativo", "Ley de Contratación Pública", "Normativa de Responsabilidad del Estado", "Reglamentos gubernamentales"]}',
		0),
		('Derecho Internacional Publico',
		'Conjunto de normas y principios que regulan las relaciones entre Estados y organismos internacionales, garantizando la convivencia pacífica y la cooperación global.',
		'{"jurisdicción": "Internacional","tipo_de_casos": ["Derechos humanos", "Relaciones entre Estados", "Organizaciones internacionales", "Tratados y acuerdos internacionales", "Resolución de conflictos internacionales"],"instituciones_relacionadas": ["Corte Internacional de Justicia", "Organización de las Naciones Unidas (ONU)", "Tribunales Internacionales", "Organización Mundial del Comercio (OMC)"],"leyes_aplicables": ["Carta de las Naciones Unidas", "Convenciones Internacionales", "Derecho Consuetudinario Internacional", "Tratados Bilaterales y Multilaterales"]}',
		1),
		('Derecho Tribunal',
		'Regula los tributos, su administración y fiscalización, estableciendo los derechos y deberes de los contribuyentes frente al Estado.',
		'{"jurisdicción": "Nacional","tipo_de_casos": ["Procedimientos judiciales", "Recursos procesales", "Ejecución de sentencias", "Medidas cautelares", "Litigación en tribunales"],"instituciones_relacionadas": ["Tribunales de Justicia", "Cortes Supremas", "Fiscalía", "Defensoría Pública"],"leyes_aplicables": ["Código de Procedimiento Civil", "Código de Procedimiento Penal", "Normativa de Tribunales", "Reglamentos Judiciales"]}',
		0),
		('Derecho de Propiedad Intelectual',
		'Protege los derechos sobre creaciones intelectuales, incluyendo patentes, marcas, derechos de autor y diseños industriales.',
		'{"jurisdicción": "Nacional e Internacional","tipo_de_casos": ["Derechos de autor", "Marcas y patentes", "Propiedad industrial", "Competencia desleal", "Licencias y regalías"],"instituciones_relacionadas": ["Oficinas de Propiedad Intelectual", "Organización Mundial de la Propiedad Intelectual (OMPI)", "Tribunales de Comercio", "Registros de Marcas y Patentes"],"leyes_aplicables": ["Ley de Propiedad Intelectual", "Convenio de París", "Acuerdo sobre los ADPIC", "Tratados de la OMPI"]}',
		1),
		('Derecho informatico',
		'Regula los derechos y obligaciones derivados del uso de las tecnologías de la información, incluyendo protección de datos, ciberseguridad y delitos informáticos.',
		'{"jurisdicción": "Nacional e Internacional","tipo_de_casos": ["Delitos informáticos", "Protección de datos personales", "Ciberseguridad", "Contratos electrónicos", "Propiedad intelectual digital"],"instituciones_relacionadas": ["Agencias de Protección de Datos", "Tribunales de Delitos Informáticos", "Organismos de Ciberseguridad", "Organización Mundial de la Propiedad Intelectual (OMPI)"],"leyes_aplicables": ["Ley de Protección de Datos", "Normativa de Ciberdelitos", "Regulación de Comercio Electrónico", "Convenio de Budapest sobre Cibercriminalidad"]}',
		1);

INSERT INTO Abogados (nombre_Abogado, rol_Abogado, contraseña, titulo_Profesional, titulo_Especialización, registro_Colegio_Abogados, cedula_de_Cuidadania, telefono, correo, idiomas, id_Especialidad)  
	VALUES  
		('Abraham Lincoln','Fundador','12345','Abogado','','1836-IL-AL-001','1836-001','+13125551836','abraham.lincoln@illinoislaw.com','{"idiomas":["Inglés"]}',2),  
		('Mahatma Gandhi','Fundador','67890','Abogado de la Corte','','1891-UK-MG-001','1756-001','+442079461891','mahatma.gandhi@uklaw.com','{"idiomas":["Inglés","Hindi","Gujarati","Afrikaans"]}',2),  
		('Nelson Mandela','Fundador','12390','Abogado de Derecho Civil','','1952-ZA-NM-001','6735-054','+27115551891','nelson.mandela@lawza.com','{"idiomas":["Inglés","Xhosa","Afrikaans"]}',2),  
		('Sarmiza Bilcescu','Abogada','10293','Abogada','','1890-RO-SB-001','1890-001','+40211234567','sarmiza.bilcescu@lawro.com','{"idiomas":["Rumano","Francés","Italiano","Alemán"]}',2),  
		('Alan Dershowitz','Abogado','001','Abogado Penalista','Derecho Penal','1966-US-AD-001','1966-001','+13055551874','alan.dershowitz@law.com','{"idiomas":["Inglés"]}',1),  
		('Cynthia Estlund','Abogada','002','Abogada Laboralista','Derecho Laboral','1980-US-CE-002','1980-002','+12125554567','cynthia.estlund@law.com','{"idiomas":["Inglés"]}',4),  
		('Madeleine Albright','Abogada','003','Internacionalista','Derecho Internacional','1976-US-MA-003','1976-003','+12025557890','madeleine.albright@law.com','{"idiomas":["Inglés","Checo","Francés"]}',7),  
		('Robert F. Kennedy Jr.','Abogado','004','Ambientalista','Derecho Administrativo','1985-US-RFK-004','1985-004','+19145553210','robert.kennedy@law.com','{"idiomas":["Inglés"]}',6),  
		('David Boies','Abogado','005','Corporativo','Derecho Mercantil','1973-US-DB-005','1973-005','+16505556543','david.boies@law.com','{"idiomas":["Inglés"]}',3),  
		('Laurence Tribe','Abogado','006','Constitucionalista','Derecho Constitucional','1970-US-LT-006','1970-006','+16175557891','laurence.tribe@law.com','{"idiomas":["Inglés"]}',5),  
		('Sonia Sotomayor','Abogada','007','Tribunal','Derecho Judicial','1992-US-SS-007','1992-007','+12025559876','sonia.sotomayor@law.com','{"idiomas":["Inglés","Español"]}',8),  
		('Lawrence Lessig','Abogado','008','Informático','Derecho Informático','1993-US-LL-008','1993-008','+16505551234','lawrence.lessig@law.com','{"idiomas":["Inglés"]}',10);  