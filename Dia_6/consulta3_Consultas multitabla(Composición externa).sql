use empresa_t2;

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.


-- 1. Devuelve un listado con todos los empleados junto con los datos de los
-- departamentos donde trabajan. Este listado también debe incluir los
-- empleados que no tienen ningún departamento asociado.

select  * from empleado  left join departamento on empleado.id_departamento=departamento.id;

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no
-- tienen ningún departamento asociado.

select distinct e.id,e.nombre, e.apellido1,  e.apellido2 , e.id_departamento from empleado e right join departamento on e.id_departamento is null;

-- 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no
-- tienen ningún empleado asociado.

select d.id, d.nombre from departamento d left join empleado  on empleado.id_departamento=d.id where empleado.id_departamento is null ;

-- 4. Devuelve un listado con todos los empleados junto con los datos de los
-- departamentos donde trabajan. El listado debe incluir los empleados que no
-- tienen ningún departamento asociado y los departamentos que no tienen
-- ningún empleado asociado. Ordene el listado alfabéticamente por el
-- nombre del departamento.

select d.id,d.nombre,e.id , e.nombre, e.apellido1, e.apellido2 from empleado e left join departamento d  on e.id_departamento=d.id order by 2; 

-- 5. Devuelve un listado con los empleados que no tienen ningún departamento
-- asociado y los departamentos que no tienen ningún empleado asociado.
-- Ordene el listado alfabéticamente por el nombre del departamento.
select d.id as Id ,d.nombre as Nombre from  departamento d  where d.id in (7,6) union all
select e.id_departamento,e.nombre from empleado e where  e.id_departamento is null ORDER BY e.nombre asc; 
