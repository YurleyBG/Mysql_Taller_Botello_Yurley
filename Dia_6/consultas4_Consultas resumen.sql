use empresa_t2;

-- Consultas resumen
-- 1. Calcula la suma del presupuesto de todos los departamentos.

delimiter //
create function suma_presupuestos ()
returns double deterministic
begin
	 declare suma_total double ;
    set suma_total= (select sum(presupuesto) from departamento) ;
    return suma_total;
end //
delimiter ;
select suma_presupuestos() as Presupuesto_total  ;

-- 2. Calcula la media del presupuesto de todos los departamentos.

delimiter //
create function media_presupuestos ()
returns double deterministic
begin
	declare suma_total double;
    declare conteo_total int ;
    declare media decimal(10,2);
    set suma_total= (select sum(presupuesto) from departamento) ;
    set conteo_total= (select count(presupuesto) from departamento) ;
    set media= suma_total/conteo_total;
    return media ;
end //
delimiter ;
select media_presupuestos() as media_presupuesto ;

-- 3. Calcula el valor mínimo del presupuesto de todos los departamentos.
delimiter //
create function valor_minimo()
returns double deterministic
begin
	 declare minimo double;
     set minimo=(select min(presupuesto) from departamento);
     return minimo;
end //
delimiter ;
select valor_minimo() as preupueto_minimo;

-- 4. Calcula el nombre del departamento y el presupuesto que tiene asignado,
-- del departamento con menor presupuesto.
delimiter //
create function presupuesto_minimo()
returns varchar(50) deterministic
begin
	declare minimo varchar(50);
	set minimo=(select nombre from departamento where presupuesto= (select  min(presupuesto) from departamento) limit 1 );
	return minimo;
end //
delimiter ;
select presupuesto_minimo() as Departamento;
-- 5. Calcula el valor máximo del presupuesto de todos los departamentos.
delimiter //
create function valor_maximo()
returns double deterministic
begin
	 declare maximo double;
     set maximo=(select max(presupuesto) from departamento);
     return maximo;
end //
delimiter ;
select valor_maximo() as preupueto_maximo;
-- 6. Calcula el nombre del departamento y el presupuesto que tiene asignado,
-- del departamento con mayor presupuesto.
delimiter //
create function presupuesto_maximo()
returns varchar(50) deterministic
begin
	declare maximo varchar(50);
	set maximo=(select nombre from departamento where presupuesto= (select  max(presupuesto) from departamento) limit 1 );
	return maximo;
end //
delimiter ;
select presupuesto_maximo() as Departamento;
-- 7. Calcula el número total de empleados que hay en la tabla empleado.
 delimiter //
 create function numero_empleados ()
 returns int deterministic
 begin 
	declare total int;
    set total = (select count(*) from empleado);
    return total ;
end //
delimiter ;

select numero_empleados ()  as Numero_empleado;
-- 8. Calcula el número de empleados que no tienen NULL en su segundo
-- apellido.
 delimiter //
 create function empleado ()
 returns int deterministic
 begin 
	declare total int;
    set total = (select count(*) from empleado where not apellido2 is null);
    return total ;
end //
delimiter ;

select empleado ()  as Numero_empleados;

-- 9. Calcula el número de empleados que hay en cada departamento. Tienes que
-- devolver dos columnas, una con el nombre del departamento y otra con el
-- número de empleados que tiene asignados.

select departamento.nombre, count(id_departamento) as empleados from empleado left join departamento 
on empleado.id_departamento=departamento.id group by 1;

-- 10. Calcula el nombre de los departamentos que tienen más de 2 empleados. El
-- resultado debe tener dos columnas, una con el nombre del departamento y
-- otra con el número de empleados que tiene asignados.

select departamento.nombre, count(id_departamento) as empleados from empleado right join departamento 
on empleado.id_departamento=departamento.id group by 1 having count(id_departamento)>2 ;

-- 11. Calcula el número de empleados que trabajan en cada uno de los
-- departamentos. El resultado de esta consulta también tiene que incluir
-- aquellos departamentos que no tienen ningún empleado asociado.

select departamento.nombre, count(id_departamento) as empleados from empleado right join departamento 
on empleado.id_departamento=departamento.id group by 1;

-- 12. Calcula el número de empleados que trabajan en cada unos de los
-- departamentos que tienen un presupuesto mayor a 200000 euros.

select departamento.nombre, count(id_departamento) as empleados from empleado inner join departamento 
on departamento.id=empleado.id_departamento where presupuesto > 200000 group by 1;