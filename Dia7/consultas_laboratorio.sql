use  laboratorio;
-- funciones

-- 1 diferecia entre el valor cotizado y el valor pagado.
delimiter //
create function diferencia ()
returns decimal deterministic
begin 
 declare valor decimal;
 set valor = (select sum(valor_cotizado) - sum(valor_pagado) from alquiler);
 return valor;
 end //
 delimiter ;
 
 select diferencia();

  

 -- 2 segun las fechas de salida y llegada sacar el valor correcto a pagar a para los clientes que alquilaron por una semana 
 delimiter //
 create function valor_pagar ()
 returns decimal deterministic
 begin 
	declare dias int;
    set dias= (select valor_semanal as valor_pago_semana from alquiler
    where datediff(fecha_llegada,fecha_salida) =7 limit 1 );
    return dias;
end //
delimiter ;
select valor_pagar();
 
 -- 3 mostrar el valor total cotizado por semana 
 
 delimiter //
 create function valor_cotizado_semana()
 returns decimal deterministic
 begin 
	declare dias int;
    set dias= (select sum(floor(datediff(fecha_llegada,fecha_salida)/7)*valor_semanal) as valor from alquiler limit 1);
    return dias;
end //
delimiter ;

select valor_cotizado_semana();
 -- 4 mostrar el valor total cotizado por dias
 
 delimiter //
 create function valor_cotizado_dias()
 returns decimal deterministic
 begin 
	declare dias int;
    set dias= (select sum(datediff(fecha_llegada,fecha_salida)%7*valor_dia) as valor from alquiler limit 1);
    return dias;
end //
delimiter ;
select valor_cotizado_dias();
 
 
 -- 5 total de alquileres donde el vehiculo fue de tipo camioneta
 delimiter //
 create function suma_alquileres()
 returns int deterministic
 begin
 declare suma int;
 set suma =(select count(idalquiler) as Total_Alquiler from alquiler inner join vehiculos on vehiculos.idvehiculos = alquiler.id_vehiculos
 where vehiculos.tipo='SUV' );
 return suma;
 end //
 delimiter ;

 select suma_alquileres() as Total_alquiler;
-- consultas

-- 1 mostrar los nombres y apellidos de los empleados 

select  nombre , apellido1, apellido2 from empleado;

-- 2 mostrar los nombres y apellidos de los empleados  y su id de sucursal

select  idsucursal, empleado.nombre,empleado.apellido1,empleado.apellido2 from empleado inner join sucursal on sucursal.idsucursal = empleado.id_sucursal;


-- 3 muestre el nombre del cliente y el nombre del empleado que los atendio

select c.id_empleado,  e.nombre  as empleado, c.nombre  as cliente from cliente c inner join empleado e on  c.id_empleado =e.idempleado;


-- 4 muestre el nombre del cliente y el tipo de vehiculo alquilado.

select c.nombre as cliente , v.tipo as tipo_vehiculos from cliente c inner join alquiler a on c.idcliente = a.id_cliente 
inner join vehiculos v on a.id_vehiculos =  v.idvehiculos ;

-- 5 muestre los tipos de vehiculos sin que se repitan. 
 select distinct tipo from vehiculos ;
 
 -- 6 muestre la cantidad de vehiculos que hay en la sucursal 2.
 select  idsucursal, count(*) as cantidad from vehiculos v inner join sucursal s on v.id_sucursal = s.idsucursal where s.idsucursal=2 group by 1;
 
 -- 7 calcular el valor total del alquiler por cliente
 
 select sum(valor_pagado) from alquiler inner join cliente on alquiler.id_cliente = cliente.idcliente;
 
 
 -- 8 segun las fechas de salida y llegada sacar el valor correcto a pagar por dias
 select datediff(fecha_llegada,fecha_salida)*valor_dia from alquiler where datediff(fecha_llegada,fecha_salida) < 7;
 
 -- 9 consultar el valor que deben pagar los que alquilaron por una semana
 
  select distinct datediff(fecha_llegada,fecha_salida)*valor_semanal from alquiler where datediff(fecha_llegada,fecha_salida) = 7;
  
  -- 10 cuantos empleados hay en cada sucursal
  select  id_sucursal , count(*) as empleados from empleado inner join sucursal on sucursal.idsucursal = empleado.id_sucursal group by 1;
  
  -- 11  muestre la cantidad de vehiculos que hay en cada sucursal .
  
   select  idsucursal, count(*) as cantidad_vehiculos from vehiculos v inner join sucursal s on v.id_sucursal = s.idsucursal  group by 1;
   
   -- 12 muestre la cantidad de empleados  en cada sucursal
   
 select  idsucursal, count(*) as cantidad_empleados from empleado e inner join sucursal s on e.id_sucursal = s.idsucursal  group by 1;
 
 -- 13 muestre la cantidad de alquileres que tiene cada clientes
 
 select idcliente, count(*) from cliente  inner join alquiler on cliente.idcliente =alquiler.id_cliente group by 1;
 
  -- 14 muestre los nombre de gerentes y la id de la sucursal a la que corresponde
  
  select gerente.nombre , idsucursal from sucursal inner join gerente on gerente.id_sucursal = sucursal.idsucursal;
  
  -- 15 muestre el total de clientes en una sucursal
  
  select idsucursal, count(*) from cliente  inner join empleado on empleado.idempleado = cliente.id_empleado 
  
  inner join sucursal on  empleado.id_sucursal = sucursal.idsucursal group by 1;
  
   -- 16 segun las fechas de salida y llegada sacar el valor correcto a pagar a para los clientes que alquilaron por una semana 
   
   select floor(datediff(fecha_llegada,fecha_salida)/7)*valor_semanal as valor from alquiler;
   
	-- 17  mostrar el valor cotizado por semana
    
    select distinct datediff(fecha_llegada,fecha_salida)*valor_semanal as valor from alquiler where datediff(fecha_llegada,fecha_salida) =7 ;
    
	-- 18 mostrar el valor cotizado por dias
    
    select datediff(fecha_llegada,fecha_salida)%7*valor_dia as valor from alquiler;
    
	 -- 19 muestrame el nombre y apellidos de los clientes de bogota
     
      select nombre, apellido1, apellido2 from cliente where ciudad ='madrid';
      
	  -- 20 muestrame los modelos de vehiculos que hay sin que estos se repitan
      
      select distinct modelos from vehiculos;
      
	  -- 21 muestrame la cantiadad de vehiculo que hay de cada tipo
      
      select tipo, count(tipo) from vehiculos group by 1;
      
	  -- 22 muestre todos los autos deportivos con sus respectivos datos
      
      select * from vehiculos  where tipo='deportivo';
      
	  -- 23 muestrame el  id, modelo, tipo, placa del vehiculo y la id de la sucursal donde este se encuentra
      
      select idvehiculos, modelos, tipo, placa, idsucursal from vehiculos inner join sucursal on vehiculos.id_sucursal=sucursal.idsucursal;
      
	  -- 24 muestre los clientes de la ciudad de madrid
	
		select * from cliente  where ciudad= 'madrid' ;
        
	  -- 25 muestre la cantidad de clientes que ha tenido un empleado
      
      select idempleado, empleado.nombre , count(idcliente) from cliente inner join empleado on cliente.id_empleado = empleado.idempleado group by 1,2;