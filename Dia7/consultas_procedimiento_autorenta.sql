-- PROCEDIMIENTOS
use laboratorio;

-- 1 actualizar las ciudades de las sucursales

delimiter //
create procedure actualizarciudad_sucursal (in id_sucursal int , in nueva_ciudad varchar(45))
begin
	update sucursal
    set ciudad = nueva_ciudad where idsucursal=id_sucursal;
    
end //
delimiter ;

call actualizarciudad_sucursal(31, 'Bogota');
select * from sucursal where idsucursal=31;


-- 2. insertar nuevos vehiculos para alquilar

delimiter //
create procedure insertar_vehiculos (in idvehiculos int, in tipo varchar(45), in placa varchar(45), in
referencia varchar(45), in  modelos varchar(45),in puerta varchar(45),
in capacidad varchar(45),in sunroof varchar(45),in motor varchar(45),in id_inventario int,in id_sucursal int)
begin 
	insert into vehiculos(idvehiculos,tipo,placa,referencia,modelos,puerta,capacidad,sunroof,motor,id_inventario,id_sucursal)
    values(idvehiculos,tipo,placa,referencia,modelos,puerta,capacidad,sunroof,motor,id_inventario,id_sucursal);
end //
delimiter ;

call insertar_vehiculos(101,'Sedan','053av6','Toyota Corolla', '2022', '4', '5', 'si', '2.0L',100,3 );
select * from vehiculos where idvehiculos =101;


-- 3 agregar nuevos clientes
delimiter //
create procedure insertar_clientes (in idcliente int, in nombre varchar(45) , in apellido1 varchar(50) , in apellido2 varchar(50),
in cedula varchar(35),in direccion varchar(45),in  ciudad varchar(45), in celular varchar(20),in id_empleado int)
begin 
	insert into cliente(idcliente,nombre,apellido1,apellido2,cedula,direccion,ciudad,celular,id_empleado)
    values(idcliente,nombre,apellido1,apellido2,cedula,direccion,ciudad,celular,id_empleado);
end //
delimiter ;

call insertar_clientes(101,'luis','perez','torrez', '106679263', 'cll 3 25-34','Bogota', '31223425', 3 );

select * from cliente where idcliente =101;

-- 4 actualizar sucursal de empleados

delimiter //
create procedure actualizar_ciudad_empleados (in id_empleado int , in ciudad1 varchar(45))
begin
	update empleado
    set ciudad= ciudad1 where idempleado=id_empleado;
    
end //
delimiter ;
drop procedure actualizar_ciudad_empleados;
call actualizar_ciudad_empleados(3,'Bogota');
select * from empleado where idempleado=3;


-- 5 eliminar clientes

delimiter //
create procedure eliminar_cliente (in id_cliente int)
begin
	declare cliente int ;
    set cliente = (select count(*) from cliente  where idcliente =id_cliente);
    if cliente = 1 then 
    delete from cliente 
    where idcliente = id_cliente;
	end if;
     
end //
delimiter ;

call eliminar_cliente (101);
select * from cliente where idcliente =101;


--  6  actualizar el valor semanal
delimiter //
create procedure update_valor_semanal (in idalquiler1 int ,in valorsemanal decimal(10,2))
begin
	update alquiler
    set valor_semanal = valorsemanal where idalquiler=idalquiler1;
end //
delimiter ;

call update_valor_semanal(1,'800');
select * from alquiler where idalquiler=1;

-- 7 actualizar valor por dias
delimiter //
create procedure update_valor_dias (in idalquileres int ,in valordias decimal(10,2))
begin
	update alquiler
    set valor_dia = valordias where idalquiler=idalquileres;
end //
delimiter ;

call update_valor_dias(1,'170');
select * from alquiler where idalquiler=1;


-- 8 actualizar la sucursal de los empleados 
delimiter //
create procedure actualizar_sucursal(in id_empleado int , in idsucursal int)
begin
	update empleado
    set id_sucursal = idsucursal where idempleado=id_empleado;
    
end //
delimiter //

call actualizar_sucursal(3,31);
select * from empleado  where idempleado=3;



-- 8 actualizar la sucursal de los vehiculos
delimiter //
create procedure actualizar_sucursal_vehiculos(in id_vehiculos int , in idsucursal int)
begin
	update vehiculos
    set id_sucursal = idsucursal where idvehiculos=id_vehiculos;
    
end //
delimiter //

call actualizar_sucursal_vehiculos(3,31);
select * from vehiculos  where idvehiculos=3;

-- 9 actualizar la id de la sucursal a la que pertenece el gerente
delimiter //
create procedure actualizar_sucursal_gerente(in id_gerente int , in idsucursal int)
begin
	update gerente
    set id_sucursal = idsucursal where idgerente=id_gerente;
    end //
delimiter //

call actualizar_sucursal_gerente(31,31);
select * from gerente  where idgerente=31;


-- 10 agregar nuevos alquileres
delimiter //
create procedure insertar_alquileres (in idalquiler int, in fecha_acordada date , in fecha_salida date , in fecha_llegada date,
in valor_semanal decimal,in valor_dia decimal,in  descuento decimal, in valor_cotizado decimal,in valor_pagado decimal ,in id_vehiculos int,in  id_cliente int)
begin 
	insert into alquiler(idalquiler,fecha_acordada,fecha_salida,fecha_llegada,valor_semanal,valor_dia,descuento,valor_cotizado,valor_pagado,id_vehiculos,id_cliente)
    values(idalquiler,fecha_acordada,fecha_salida,fecha_llegada,valor_semanal,valor_dia,descuento,valor_cotizado,valor_pagado,id_vehiculos,id_cliente);
end //
delimiter ;

call insertar_alquileres(101,'2024-11-19','2024-11-15','2024-11-19', '700', '100','5', '400', '380' ,101,1);

select * from alquiler where idalquiler =101;
