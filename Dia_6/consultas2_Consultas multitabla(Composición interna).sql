use empresa_t2;

-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

--  1. Devuelve un listado con los empleados y los datos de los departamentos
-- donde trabaja cada uno.

select * from empleado inner join departamento on empleado.id_departamento=departamento.id;

-- 2. Devuelve un listado con los empleados y los datos de los departamentos
-- donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre
-- del departamento (en orden alfabético) y en segundo lugar por los apellidos
-- y el nombre de los empleados.

select departamento.nombre, empleado.apellido1,empleado.apellido2,empleado.nombre from empleado 
inner join departamento on empleado.id_departamento=departamento.id order by 1, 2,3,4 asc;

-- 3. Devuelve un listado con el identificador y el nombre del departamento,
-- solamente de aquellos departamentos que tienen empleados.

select distinct d.id, d.nombre from departamento d inner join empleado  e on d.id=e.id_departamento;

-- 4. Devuelve un listado con el identificador, el nombre del departamento y el
-- valor del presupuesto actual del que dispone, solamente de aquellos
-- departamentos que tienen empleados. El valor del presupuesto actual lo
-- puede calcular restando al valor del presupuesto inicial
-- (columna presupuesto) el valor de los gastos que ha generado
-- (columna gastos).

delimiter //
create function valor_presupuesto (presupuesto double , gastos double)
returns double deterministic
begin
	declare total  double;
     set total= presupuesto - gastos;
     return total;
end //
delimiter ;

select distinct departamento.id,departamento.nombre,valor_presupuesto(presupuesto, gastos) as presupuesto_actual from departamento
 inner join empleado on departamento.id=empleado.id_departamento;
 
-- 5. Devuelve el nombre del departamento donde trabaja el empleado que tiene
-- el nif 38382980M.

select departamento.nombre as Departamento from departamento inner join empleado  
on departamento.id=empleado.id_departamento where empleado.nif ='38382980M';

-- 6. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz
-- Santana.

select departamento.nombre as Departamento from departamento inner join empleado  
on departamento.id=empleado.id_departamento where empleado.nombre ='Pepe'and empleado.apellido1 ='Ruiz'
and empleado.apellido2 ='Santana' ;

-- 7. Devuelve un listado con los datos de los empleados que trabajan en el
-- departamento de I+D. Ordena el resultado alfabéticamente.
select e.id, e.nif, e.nombre, e.apellido1, e.apellido2,e.id_departamento from departamento inner join empleado e 
on departamento.id=e.id_departamento where departamento.nombre ='I+D' order by 3,4,5 asc;

-- 8. Devuelve un listado con los datos de los empleados que trabajan en el
-- departamento de Sistemas, Contabilidad o I+D. Ordena el resultado
-- alfabéticamente.

select e.id, e.nif, e.nombre, e.apellido1, e.apellido2,e.id_departamento from departamento inner join empleado e 
on departamento.id=e.id_departamento where departamento.nombre in ('Sistemas','I+D','Contabilidad') order by 3,4,5 asc;

-- 9. Devuelve una lista con el nombre de los empleados que tienen los
-- departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

select e.nombre from departamento inner join empleado e 
on departamento.id=e.id_departamento where departamento.presupuesto between 100000 and 200000;

-- 10. Devuelve un listado con el nombre de los departamentos donde existe
-- algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no
-- debe mostrar nombres de departamentos que estén repetidos.

select distinct departamento.nombre from departamento inner join empleado e 
on departamento.id=e.id_departamento where e.apellido2 is null;