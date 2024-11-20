CREATE DATABASE ventasT2;
USE ventasT2;

CREATE TABLE cliente (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  categoria INT UNSIGNED
);

CREATE TABLE comercial (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  comision FLOAT
);

CREATE TABLE pedido (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  total DOUBLE NOT NULL,
  fecha DATE,
  id_cliente INT UNSIGNED NOT NULL,
  id_comercial INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

INSERT INTO cliente (id, nombre, apellido1, apellido2, ciudad, categoria) VALUES
(1, 'Carlos', 'Martínez', 'González', 'Madrid', 100),
(2, 'Lucía', 'Pérez', 'Fernández', 'Barcelona', 200),
(3, 'Ricardo', 'Gómez', 'López', 'Valencia', NULL),
(4, 'Ana', 'Díaz', 'Sánchez', 'Sevilla', 300),
(5, 'Sofía', 'Ramírez', 'Moreno', 'Zaragoza', 200),
(6, 'Juan', 'López', 'García', 'Bilbao', 100),
(7, 'Beatriz', 'González', 'Rodríguez', 'Málaga', 300),
(8, 'David', 'Martínez', 'Hernández', 'Alicante', 200),
(9, 'Pedro', 'Ruiz', 'Santos', 'Palma de Mallorca', 225),
(10, 'Laura', 'Vázquez', 'Pérez', 'Murcia', 125);

INSERT INTO comercial (id, nombre, apellido1, apellido2, comision) VALUES
(1, 'Antonio', 'Vega', 'Pérez', 0.18),
(2, 'Isabel', 'Moreno', 'Sánchez', 0.15),
(3, 'Javier', 'Fernández', 'Martín', 0.14),
(4, 'Elena', 'Hernández', 'Díaz', 0.13),
(5, 'Ricardo', 'Martínez', 'Gómez', 0.12),
(6, 'Laura', 'Sánchez', 'López', 0.10),
(7, 'Marta', 'Rodríguez', 'García', 0.11),
(8, 'Francisco', 'Gómez', 'Ruiz', 0.09);

INSERT INTO pedido (id, total, fecha, id_cliente, id_comercial) VALUES
(1, 350.75, '2024-02-15', 5, 2),
(2, 1200.50, '2024-03-01', 1, 5),
(3, 530.10, '2024-01-22', 2, 1),
(4, 800.20, '2023-12-14', 8, 3),
(5, 5000.00, '2023-11-30', 5, 2),
(6, 2200.99, '2023-10-25', 7, 1),
(7, 6000.50, '2023-09-10', 2, 1),
(8, 1900.30, '2023-08-21', 4, 6),
(9, 2300.45, '2023-07-10', 8, 3),
(10, 280.95, '2023-06-15', 8, 2),
(11, 150.60, '2023-05-17', 3, 7),
(12, 2500.99, '2024-04-05', 2, 1),
(13, 550.80, '2023-11-18', 6, 1),
(14, 135.75, '2023-10-25', 6, 1),
(15, 480.45, '2024-05-12', 1, 5),
(16, 1200.60, '2024-06-03', 1, 5);



-- FUNCIONES

-- 1 obtener el total de pedidos realizados por un cliente

delimiter //
create function total_pedidos( idcliente int)
returns int deterministic
begin
 declare total_de_pedidos int ;
 set total_de_pedidos = (select count(id_cliente) from pedido where pedido.id_cliente=idcliente );
 return total_de_pedidos;
end //
delimiter ;

select total_pedidos(1) ;

select nombre , count(id_cliente) from pedido inner join cliente on cliente.id =pedido.id_cliente group by 1;


-- 2 calcular la comision total ganada por un comercial

delimiter //
create function total_comercial (idcomercial int)
returns float deterministic
begin 
	declare total float;
    set total = (select sum(comision) from comercial 
    inner join pedido on comercial.id = pedido.id_comercial where comercial.id = idcomercial);
    return total;
end//
delimiter ;

select total_comercial(3);

-- consulta

select sum(comision) from comercial inner join pedido on comercial.id = pedido.id_comercial where pedido.id_comercial = 3;

-- 3 obtener el cliente con mayor total de  pedidos realizados en un año especifico 

delimiter //
create function cliente_pedido_año ( idclientes int)
returns int deterministic
begin
	declare total int ;
    set total=(select count( pedido.id_cliente) from pedido where  pedido.id_cliente =idclientes limit 1) ;
    return total;
end//
delimiter ;

select c.nombre,cliente_pedido_año( id ) as total_pedidos from cliente c group by 1,2 order by 2 desc limit 1 ;

-- consulta 
select nombre, count(id_cliente) from pedido p inner join cliente on cliente.id=p.id_cliente group by 1;


-- 4 contar la realidad de pedidos realizados en año especifico

 delimiter //
 create function pedidos_años (año varchar(20) )
 returns  int deterministic
 begin
 declare pedidos int ;
 set pedidos= (select count(*) from pedido where year(fecha)=año);
 return pedidos;
 end //
 delimiter ;
 
 select pedidos_años('2023') as Total_pedidos_año;
 
 -- consultas 
 select count(*) from pedido where year(fecha)='2023' ;
 select count(*) from pedido where year(fecha)='2024';


-- 5 obtener el promedio total de pedidos por clientes

delimiter //
create function promedio (id int)
returns decimal (10,2) deterministic 
begin
declare promedio decimal(10,2);
	set promedio = (select avg(total_clientes) as promedio from (select count(id_cliente) as 'total_clientes' 
	from pedido where pedido.id_cliente=id limit 1 ) as obtener);
	return promedio;
end //
delimiter ;

select  promedio (8) as promedio;

-- consulta
select avg(total_clientes) as promedio from (select count(id_cliente) as 'total_clientes' 
from pedido where pedido.id_cliente =1 limit 1 ) as obtener;

