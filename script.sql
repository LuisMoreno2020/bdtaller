CREATE DATABASE if not exists Biblioteca;

USE Biblioteca;

CREATE TABLE if not exists Cargo (
	CodCargo int not null auto_increment,
	NombreCargo varchar(25) not null,
	CONSTRAINT PK_CARGO_CodCargo
	PRIMARY KEY (CodCargo)
	);

CREATE TABLE if not exists Usuario (
	RutUsuario int(8) not null,
	DvUsuario varchar(1) not null,
	Nombres varchar(25) not null,
	ApellidoPaterno varchar(25) not null,
	ApellidoMaterno varchar(25) not null,
	Email varchar(35) null,
	Activo boolean not null, 
	Contraseña varchar(15) not null,
   	CONSTRAINT PK_Usuario_RutUsuario
	PRIMARY KEY (RutUsuario));


CREATE TABLE if not exists TelefonoUsuario (
	IdTelefono int not null auto_increment,
	Telefono int not null,
	RutUsuario int(8) not null,
	CONSTRAINT PK_TelefonoUsuario_Idtelefono
	PRIMARY KEY (IdTelefono),
	CONSTRAINT FK_TelefonoUsuario_RutUsuario
	FOREIGN KEY (RutUsuario) REFERENCES Usuario(RutUsuario));

CREATE TABLE if not exists Usuario_Cargo (
	RutUsuario int(8) not null,
	CodCargo int not null,
	CONSTRAINT FK_Usuario_Cargo_RutUsuario
	FOREIGN KEY (RutUsuario) REFERENCES Usuario(RutUsuario),
	CONSTRAINT FK_Usuario_CARgo_CodCargo
    FOREIGN KEY (CodCargo) REFERENCES Cargo(CodCargo));

CREATE TABLE if not exists Log (
	RutUsuario int(8) not null,
	Movimiento varchar(30) not null,
	Fecha date not null,
	CONSTRAINT FK_Log_RutUsuario
    FOREIGN KEY(RutUsuario) REFERENCES Usuario(RutUsuario));

CREATE TABLE if not exists Letra (
	CodLetra int not null auto_increment,
	Letra varchar(1) not null,
	CONSTRAINT PK_Letra_CodLetra
	PRIMARY KEY (CodLetra)
	);

CREATE TABLE if not exists Nivel (
	CodNivel int not null,
	Nivel varchar(10) not null,
	CONSTRAINT PK_Nivel_CodNivel
	PRIMARY KEY (CodNivel)
	);

CREATE TABLE if not exists Curso (
	CodCurso int not null auto_increment,
	Curso int(1) not null,
	CONSTRAINT PK_Curso_CodCurso
	PRIMARY KEY (CodCurso)
	);


CREATE TABLE if not exists Alumno (
	RutAlumno int(8) not null,
	DvAlumno varchar(1) not null,
	Nombres varchar(25) not null,
	ApellidoPaterno varchar(25) not null,
	ApellidoMaterno varchar(25) not null,
	Calle varchar(35) not null,
	Numero int not null,
	CodCurso int not null,
	CodLetra int not null,
	CodNivel int not null,
	CONSTRAINT PK_Alumno_RutAlumno
	PRIMARY KEY (RutAlumno),
	CONSTRAINT FK_Alumno_CodCurso
	FOREIGN KEY (CodCurso) REFERENCES Curso(CodCurso),
	CONSTRAINT FK_Alumno_CodLetra
	FOREIGN KEY (CodLetra) REFERENCES Letra(CodLetra),
	CONSTRAINT FK_Alumno_CodNivel
	FOREIGN KEY (CodNivel) REFERENCES Nivel(CodNivel)
	);
    

CREATE TABLE if not exists TelefonoAlumno (
	IdTelefono int not null auto_increment,
	Telefono int not null,
	RutAlumno int(8) not null,
	CONSTRAINT PK_TelefonoAlumno_Idtelefono
	PRIMARY KEY (IdTelefono),
	CONSTRAINT FK_TelefonoAlumno_RutAlumno
	FOREIGN KEY (RutAlumno) REFERENCES Alumno(RutAlumno)
	);

CREATE TABLE if not exists Prestamo (
	Nro int not null auto_increment,
	RutUsuario int(8) not null,
	DvUsuario varchar(1) not null,
	RutAlumno int(8) not null,
	DvAlumno varchar(1) not null,
	Emision date not null,
	CONSTRAINT PK_Prestamo_Nro
	PRIMARY KEY (Nro),
	CONSTRAINT FK_Prestamo_RutUsuario
	FOREIGN KEY (RutUsuario) references Usuario(RutUsuario),
	CONSTRAINT FK_Prestamo_RutAlumno
	FOREIGN KEY (RutAlumno) references Alumno(RutAlumno)
	CONSTRAINT FK_Prestamo_Emision
	FOREIGN KEY (Emision) references Alumno(RutAlumno)
	);

ALTER TABLE `prestamo` CHANGE `Emision` `Emision` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP;

CREATE TABLE if not exists Autor (
	CodAutor int not null auto_increment,
	NombreAutor varchar (30),
	CONSTRAINT PK_autor_CodAutor
	PRIMARY KEY (CodAutor)
	);

CREATE TABLE if not exists Categoria (
	CodCategoria int not null auto_increment,
	NombreCategoria varchar(30),
	CONSTRAINT PK_Categoria_CodCategoria
	PRIMARY KEY (CodCategoria)
	);

CREATE TABLE if not exists Libro (
	CodLibro int not null auto_increment,
	Isbn varchar(13) not null,
	Titulo varchar(100) not null,
	NroPagina int not null,
	Autor int not null,
	CodCategoria int not null,
	CONSTRAINT PK_libro_CodLibro
	PRIMARY KEY(CodLibro),
	CONSTRAINT FK_Autor_Autor
	FOREIGN KEY (Autor) references Autor(CodAutor),
	CONSTRAINT FK_Autor_CodCategoria
	FOREIGN KEY (CodCategoria) references Categoria(CodCategoria)
	);

ALTER TABLE Libro
ADD CONSTRAINT UNQ_Libro_Isbn UNIQUE (Isbn),
ADD CONSTRAINT CHK_Libro_NroPagina CHECK (NroPagina>0)
    
CREATE TABLE if not exists libro_autor (
	CodLibro int not null,
	CodAutor int not null,
	CONSTRAINT FK_libro_autor_codlibro
	FOREIGN KEY (CodLibro) REFERENCES Libro(CodLibro),
	CONSTRAINT FK_libro_autor_CodAutor
	FOREIGN KEY (CodAutor) REFERENCES autor(CodAutor)
);

CREATE TABLE if not exists Ubicacion (
    CodUbicacion int not null auto_increment,
    NombreUbicacion varchar(25),
    CONSTRAINT PK_Ubicacion_CodUbicacion
    PRIMARY KEY (CodUbicacion)
    );

CREATE TABLE if not exists Ejemplar (
	CodEjemplar int not null auto_increment,
	CodLibro int not null,
	CodUbicacion int not null,
	Estado int not null,
	Activo boolean not null,
	CONSTRAINT PK_ejemplar_CodEjemplar
	PRIMARY KEY (CodEjemplar),
	CONSTRAINT PK_Ejemplar_CodLibro
	FOREIGN KEY(CodLibro) references Libro(CodLibro),
	CONSTRAINT PK_Ejemplar_Ubicacion
	FOREIGN KEY(CodUbicacion) references Ubicacion(CodUbicacion)
	);

ALTER table Ejemplar
ADD CONSTRAINT CHK_EJEMPLAR_ESTADO CHECK (estado>=0 and estado<=1);
ADD CONSTRAINT CHK_EJEMPLAR_ACTIVO CHECK (Activo>=0 and Activo<=1);

CREATE TABLE if not exists DetallePrestamo (
	NroPrestamo int not null,
	Codigo int(15) not null,
	DiasPropuestos int not null,
	FechaDevPropuesta date not null,
	Comentario text null,
	FechaDevolucionReal date not null,	
	CONSTRAINT FK_DetallePrestamo_NroPrestamo
	FOREIGN KEY (NroPrestamo) references Prestamo(Nro),
	CONSTRAINT FK_DetallePrestamo_Codigo
	FOREIGN KEY (Codigo) references Ejemplar(CodEjemplar),
	);

