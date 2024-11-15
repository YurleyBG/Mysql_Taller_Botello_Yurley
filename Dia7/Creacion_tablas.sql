create database laboratorio;
use laboratorio;

create table informe(
	idinforme int not null primary key,
    fecha_informe date not null,
    descripcion text not null,
    cantidad_alquiler int 
);

create table sucursal (
	idsucursal int not null primary key,
    ciudad varchar(45) not null,
    direccion varchar(50) not null,
    telefono_fijo varchar(50) ,
    celular varchar(45) not null ,
    email varchar(50) not null,
	id_informe int,
    foreign key (id_informe) references informe(idinforme)
);
create table gerente (
	idgerente int not null primary key,
    nombre varchar(45) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) ,
    ciudad varchar(45) not null ,
    telefono varchar(20) not null,
    email varchar(45) not null,
    id_sucursal int,
    foreign key (id_sucursal) references sucursal(idsucursal)
);
create table inventario(
	idinventario int not null primary key,
    cantidad int not null,
    fecha_llegada date not null,
    fecha_salida date 

);

create table empleado (
	idempleado int not null primary key,
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) ,
    cedula varchar(35) not null,
    direccion varchar(45) not null,
    ciudad varchar(45) not null ,
    celular varchar(20) not null,
    email varchar(45) not null,
	id_sucursal int,
    foreign key (id_sucursal) references sucursal(idsucursal)
);
create table cliente (
	idcliente int not null primary key,
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) ,
    cedula varchar(35) not null,
    direccion varchar(45) not null,
    ciudad varchar(45) not null ,
    celular varchar(20) not null,
	id_empleado int,
    foreign key (id_empleado) references empleado(idempleado)
);

create table vehiculos(
	idvehiculos int not null primary key,
    tipo varchar(45) not null,
    placa varchar(45) not null,
    referencia varchar(45) ,
    modelos varchar(45) not null,
    puerta varchar(45) not null,
    capacidad varchar(45) not null ,
    sunroof varchar(45) not null,
    motor varchar(45) not null,
    id_inventario int,
    foreign key (id_inventario) references inventario(idinventario),
	id_sucursal int,
    foreign key (id_sucursal) references sucursal(idsucursal)
    
);
create table alquiler (
	idalquiler int not null primary key,
	fecha_acordada date not null,
    fecha_salida date not null,
    fecha_llegada date not null,
    valor_semanal decimal not null ,
    valor_dia decimal not null,
    descuento decimal ,
    valor_cotizado decimal not null ,
    valor_pagado decimal not null,
    id_vehiculos int,
    foreign key (id_vehiculos) references vehiculos(idvehiculos),
    id_cliente int,
    foreign key (id_cliente) references cliente(idcliente)
)


