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
	fecha_Fin DATE,
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

/*Vistas Casos*/
CREATE VIEW info_Casos AS
	SELECT 
		a.nombre_Abogado, a.titulo_Profesional, a.rol_Abogado,
		cl.id_Caso AS 'ID_de_Caso', 
		demandante.nombre_Cliente AS Demandante,
		demandado.nombre_Cliente AS Demandado,
		ej.nombre_Area_Practica AS 'tipo_de_Caso', 
		cl.estado_de_Caso AS Estado, 
		cl.fecha_Inicio AS 'fecha_de_Inicio', 
		cl.fecha_Fin AS 'fecha_de_Fin'
	FROM Abogados a
	INNER JOIN Abogados_Casos ac
		ON a.id_Abogado = ac.id_Abogado
	INNER JOIN Casos_Legales cl 
		ON cl.id_Caso = ac.id_Caso
	INNER JOIN Especialidades_Juridicas ej
		ON cl.id_Especialidad = ej.id_Especialidad
	INNER JOIN Clientes_Casos cc_demandante 
		ON cl.id_Caso = cc_demandante.id_Caso
	INNER JOIN Clientes demandante
		ON cc_demandante.id_Cliente = demandante.id_Cliente AND demandante.tipo_de_Participación = 'Demandante'
	INNER JOIN Clientes_Casos cc_demandado 
		ON cl.id_Caso = cc_demandado.id_Caso
	INNER JOIN Clientes demandado
		ON cc_demandado.id_Cliente = demandado.id_Cliente AND demandado.tipo_de_Participación = 'Demandado';

CREATE VIEW involucrados_Caso AS
	SELECT cc.id_Caso, c.nombre_Cliente, c.tipo_de_Participación
	FROM Clientes_Casos cc
	INNER JOIN Clientes c
		ON cc.id_Cliente = c.id_Cliente
	INNER JOIN Casos_Legales cl
		ON cc.id_Caso = cl.id_Caso
	ORDER BY cc.id_Caso;

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

INSERT INTO Casos_Legales(estado_de_Caso, descripción, fecha_Inicio, fecha_Fin, id_Especialidad)
	VALUES
		('Activo','Empleado demanda a su empresa por despido injustificado; se debate si fue por incumplimiento de contrato o faltas laborales.','2025-05-01',NULL,4),
		('Activo', 'Un ciudadano enfrenta cargos de robo y espera juicio penal.', '2025-04-10', NULL, 1),
		('Pausado', 'Disputa sobre la propiedad de un terreno entre dos familias.', '2025-02-15', NULL, 2),
		('Archivado', 'Empresa enfrenta demandas por incumplimiento de contrato mercantil.', '2024-10-01', '2025-01-20', 3),
		('Culminado', 'Trabajador logra acuerdo en demanda por accidente laboral.', '2024-08-12', '2024-12-05', 4),
		('Activo', 'Se solicita amparo contra una ley que limita derechos ciudadanos.', '2025-03-05', NULL, 5),
		('Pausado', 'Funcionario impugna sanción administrativa impuesta.', '2025-01-20', NULL, 6),
		('Activo', 'Demanda internacional por violación de tratados bilaterales.', '2025-04-01', NULL, 7),
		('Culminado', 'Persona logra nulidad de sentencia en tribunal superior.', '2024-06-15', '2024-09-30', 8),
		('Activo', 'Empresa enfrenta disputa por derechos de una marca registrada.', '2025-03-22', NULL, 9),
		('Activo', 'Caso de fraude en comercio electrónico bajo derecho informático.', '2025-05-02', NULL, 10),
		('Archivado', 'Hombre absuelto de cargos de agresión tras evidencia de defensa propia.', '2024-05-20', '2024-09-10', 1),
		('Activo', 'Disputa por herencia entre hermanos bajo derecho civil.', '2025-03-10', NULL, 2),
		('Pausado', 'Empresa demanda a proveedor por entrega de productos defectuosos.', '2024-11-01', NULL, 3),
		('Culminado', 'Trabajador gana juicio por despido sin causa justificada.', '2024-07-05', '2024-11-15', 4),
		('Activo', 'Ciudadano interpone acción de inconstitucionalidad por nueva reforma.', '2025-04-20', NULL, 5),
		('Archivado', 'Funcionario apela sanción administrativa pero el caso se archiva.', '2024-09-25', '2025-01-15', 6),
		('Activo', 'Estado enfrenta reclamación por daños en litigio internacional.', '2025-02-28', NULL, 7),
		('Culminado', 'Ciudadano logra reabrir su caso ante el tribunal de última instancia.', '2024-03-18', '2024-06-25', 8),
		('Activo', 'Conflicto entre empresas sobre uso indebido de patente.', '2025-01-05', NULL, 9),
		('Activo', 'Ciberataque a plataforma de pagos digitales genera demanda.', '2025-05-05', NULL, 10);

INSERT INTO Abogados_Casos (id_Abogado,id_Caso)
	VALUES
		(5,2),
		(5,12),
		(2,3),
		(4,13),
		(9,4),
		(9,14),
		(6,1),
		(6,5),
		(6,15),
		(10,6),
		(10,16),
		(8,7),
		(8,17),
		(7,8),
		(7,18),
		(11,9),
		(11,19),
		(12,11),
		(12,21);

INSERT INTO Clientes (nombre_Cliente, cedula_de_Ciudadanía, telefono, correo_Electronico, tipo_de_Participación)
	VALUES
		('Laura Torres','1000123456','3001234567','laura.torres@mail.com','Demandante'),
		('Martín Rojas','1000123457','3001234568','martin.rojas@mail.com','Demandado'),
		('Carla Mendoza','1000123458','3001234569','carla.mendoza@mail.com','Demandante'),
		('Esteban Vargas','1000123459','3001234570','esteban.vargas@mail.com','Demandado'),
		('Paula Carrillo','1000123460','3001234571','paula.carrillo@mail.com','Demandante'),
		('Andrés Salazar','1000123461','3001234572','andres.salazar@mail.com','Demandado'),
		('Rosa Pineda','1000123462','3001234573','rosa.pineda@mail.com','Demandante'),
		('Diego Fuentes','1000123463','3001234574','diego.fuentes@mail.com','Demandado'),
		('Mónica Herrera','1000123464','3001234575','monica.herrera@mail.com','Demandante'),
		('Iván Castillo','1000123465','3001234576','ivan.castillo@mail.com','Demandado'),
		('Susana Díaz','1000123466','3001234577','susana.diaz@mail.com','Demandante'),
		('Jorge Miranda','1000123467','3001234578','jorge.miranda@mail.com','Demandado'),
		('Fabiola Ruiz','1000123468','3001234579','fabiola.ruiz@mail.com','Demandante'),
		('Leonardo Bravo','1000123469','3001234580','leonardo.bravo@mail.com','Demandado'),
		('Mariela Paz','1000123470','3001234581','mariela.paz@mail.com','Testigo'),
		('Gabriel Luna','1000123471','3001234582','gabriel.luna@mail.com','Demandante'),
		('Sara Molina','1000123472','3001234583','sara.molina@mail.com','Demandado'),
		('Claudia Vélez','1000123473','3001234584','claudia.velez@mail.com','Testigo'),
		('Oscar Núñez','1000123474','3001234585','oscar.nunez@mail.com','Demandante'),
		('Diana Cárdenas','1000123475','3001234586','diana.cardenas@mail.com','Demandado'),
		('Renato Paredes','1000123476','3001234587','renato.paredes@mail.com','Testigo'),
		('Elsa Romero','1000123477','3001234588','elsa.romero@mail.com','Demandante'),
		('Luis Meza','1000123478','3001234589','luis.meza@mail.com','Demandado'),
		('Patricia Ayala','1000123479','3001234590','patricia.ayala@mail.com','Testigo'),
		('Daniel Espinoza','1000123480','3001234591','daniel.espinoza@mail.com','Demandante'),
		('Verónica Campos','1000123481','3001234592','veronica.campos@mail.com','Demandado'),
		('Nicolás Peña','1000123482','3001234593','nicolas.pena@mail.com','Testigo'),
		('Carlos Gómez','2000100001','3009876543','carlos.gomez@mail.com','Demandante'),
		('Ana López','2000100002','3009876544','ana.lopez@mail.com','Demandado'),
		('Felipe Torres','2000100003','3009876545','felipe.torres@mail.com','Testigo'),
		('Julia Martínez','2000100004','3009876546','julia.martinez@mail.com','Testigo'),
		('Ricardo Pérez','2000100005','3009876547','ricardo.perez@mail.com','Beneficiario'),
		('Luis Díaz','2000100006','3009876548','luis.diaz@mail.com','Demandante'),
		('Beatriz Castro','2000100007','3009876549','beatriz.castro@mail.com','Demandado'),
		('Óscar Ruiz','2000100008','3009876550','oscar.ruiz@mail.com','Tercer Interveniente'),
		('Patricia Sánchez','2000100009','3009876551','patricia.sanchez@mail.com','Testigo'),
		('Eduardo Romero','2000100010','3009876552','eduardo.romero@mail.com','Testigo'),
		('Mario Gómez','2000100011','3009876553','mario.gomez@mail.com','Demandante'),
		('Carmen Martínez','2000100012','3009876554','carmen.martinez@mail.com','Demandado'),
		('Raúl Fernández','2000100013','3009876555','raul.fernandez@mail.com','Beneficiario'),
		('Gloria Díaz','2000100014','3009876556','gloria.diaz@mail.com','Testigo'),
		('Ricardo Herrera','2000100015','3009876557','ricardo.herrera@mail.com','Tercer Interveniente'),
		('Javier Gómez','2000100016','3009876558','javier.gomez@mail.com','Demandante'),
		('Lucía Rodríguez','2000100017','3009876559','lucia.rodriguez@mail.com','Demandado'),
		('Martín Sánchez','2000100018','3009876560','martin.sanchez@mail.com','Testigo'),
		('Verónica González','2000100019','3009876561','veronica.gonzalez@mail.com','Testigo'),
		('Rosa Hernández','2000100020','3009876562','rosa.hernandez@mail.com','Beneficiario'),
		('Pedro González','2000100021','3009876563','pedro.gonzalez@mail.com','Demandante'),
		('Manuel López','2000100022','3009876564','manuel.lopez@mail.com','Demandado'),
		('Raquel Martínez','2000100023','3009876565','raquel.martinez@mail.com','Testigo'),
		('José Luis Pérez','2000100024','3009876566','jose.luis.perez@mail.com','Tercer Interveniente'),
		('Teresa Rodríguez','2000100025','3009876567','teresa.rodriguez@mail.com','Beneficiario'),
		('Tomás Ramos','2000100026','3009876568','tomas.ramos@mail.com','Demandante'),
		('Margarita García','2000100027','3009876569','margarita.garcia@mail.com','Demandado'),
		('Alfredo Martínez','2000100028','3009876570','alfredo.martinez@mail.com','Testigo'),
		('Héctor Sánchez','2000100029','3009876571','hector.sanchez@mail.com','Tercer Interveniente'),
		('Julia Castro','2000100030','3009876572','julia.castro@mail.com','Beneficiario'),
		('Daniela Peña','2000100031','3009876573','daniela.pena@mail.com','Demandante'),
		('Joaquín Jiménez','2000100032','3009876574','joaquin.jimenez@mail.com','Demandado'),
		('Francisco Díaz','2000100033','3009876575','francisco.diaz@mail.com','Testigo'),
		('Susana García','2000100034','3009876576','susana.garcia@mail.com','Tercer Interveniente'),
		('Carlos Rodríguez','2000100035','3009876577','carlos.rodriguez@mail.com','Beneficiario'),
		('Pedro Sánchez','2000100036','3009876578','pedro.sanchez@mail.com','Demandante'),
		('Celia Torres','2000100037','3009876579','celia.torres@mail.com','Demandado'),
		('Miguel Ángel Pérez','2000100038','3009876580','miguel.angel.perez@mail.com','Testigo'),
		('Laura Ortega','2000100039','3009876581','laura.ortega@mail.com','Testigo'),
		('Raúl López','2000100040','3009876582','raul.lopez@mail.com','Tercer Interveniente'),	
		('Samuel Martínez','2000100041','3009876583','samuel.martinez@mail.com','Demandante'),
		('Patricia González','2000100042','3009876584','patricia.gonzalez@mail.com','Demandado'),
		('Alejandro Pérez','2000100043','3009876585','alejandro.perez@mail.com','Testigo'),
		('Esther Hernández','2000100044','3009876586','esther.hernandez@mail.com','Tercer Interveniente'),
		('Manuela Gómez','2000100045','3009876587','manuela.gomez@mail.com','Beneficiario'),
		('Carlos Pérez','2000100046','3009876588','carlos.perez@mail.com','Demandante'),
		('David Sánchez','2000100047','3009876589','david.sanchez@mail.com','Demandado'),
		('Elena Rodríguez','2000100048','3009876590','elena.rodriguez@mail.com','Testigo'),
		('Luis Gómez','2000100049','3009876591','luis.gomez@mail.com','Tercer Interveniente'),
		('Valentina Castro','2000100050','3009876592','valentina.castro@mail.com','Beneficiario'),
		('Antonio Garzón','2000100051','3009876593','antonio.lopez@mail.com','Demandante'),
		('José Ramos','2000100052','3009876594','jose.ramos@mail.com','Demandado'),
		('Marta Pérez','2000100053','3009876595','marta.perez@mail.com','Testigo'),
		('Oscar Martínez','2000100054','3009876596','oscar.martinez@mail.com','Tercer Interveniente'),
		('Verónica Marquez','2000100055','3009876597','veronica.marquez@mail.com','Beneficiario');

INSERT INTO Clientes_Casos (id_Cliente,id_Caso)
	VALUES
		(1,1),
		(2,1),
		(3,2),
		(4,2),
		(5,3),
		(6,3),
		(7,4),
		(8,4),
		(9,5),
		(10,5),
		(11,6),
		(12,6),
		(13,7),
		(14,7),
		(15,7),
		(16,8),
		(17,8),
		(18,8),
		(19,9),
		(20,9),
		(21,9),
		(22,10),
		(23,10),
		(24,10),
		(25,11),
		(26,11),
		(27,11),
		(28,12),
		(29,12),
		(30,12),
		(31,12),
		(32,12),
		(33,13),
		(34,13),
		(35,13),
		(36,13),
		(37,13),
		(38,13),
		(39,13),
		(40,14),
		(41,14),
		(42,14),
		(43,14),
		(44,14),
		(45,15),
		(46,15),
		(47,15),
		(48,15),
		(49,15),
		(50,15),
		(51,15),
		(52,16),
		(53,16),
		(54,16),
		(55,16),
		(56,16),
		(57,17),
		(58,17),
		(59,17),
		(60,17),
		(61,17),
		(62,17),
		(63,17),
		(64,18),
		(65,18),
		(66,18),
		(67,18),
		(68,18),
		(69,19),
		(70,19),
		(71,19),
		(72,19),
		(73,19),
		(74,19),
		(75,19),
		(76,20),
		(77,20),
		(78,20),
		(79,20),
		(80,20),
		(81,21),
		(82,21);