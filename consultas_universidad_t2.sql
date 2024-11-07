USE universidad_T2;

-- 1)devuelve  un listado con el primer apellido, segundo apellido
-- y el numero de todo los alumnos . el  listado debera
-- estar ordenado alfabeticamente de menor a mayor por el 
-- primer apellido
-- segundo apellido y nombre

select apellido1 as Apellido_1, apellido2 as Apellido_1, nombre as Nombre from alumno
order by 1,2,3 asc;

-- 2)averiguar el nombre y los dos apellidos de los alumnos 
-- que no han dado de alta su numero de telefono en la base 
-- de datos

select nombre, apellido1, apellido2 from alumno where telefono is null;

-- 3)devuelva un listado

select *from asignatura where asignatura.cuatrimestre=1 and id_grado=7 and curso=3;

-- 4)devuelva el listado con todas las asignaturas ofertadas 
-- en el grado en ingenieria informatica (plan 2015)
select * from asignatura a inner join grado on a.id_grado = grado.id where grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
select * from asignatura where  id_grado = 4;

-- 5) devuelve un listado con todos los alumnos que se han matriculado en
-- alguna asignaturas durante el curso (2017-2018)

select asignatura.nombre as asignatura, alumno.nombre, c.anyo_inicio, anyo_fin  from  alumno_se_matricula_asignatura  am 
inner join alumno inner join asignatura inner join curso_escolar c 
on alumno.id = am.id_alumno  and asignatura.id = am.id_asignatura 
and am.id_curso_escolar = c.id where am.id_curso_escolar ='4'   ;

-- 6) Devuelve el número total de alumnas que hay.
select nombre , apellido1, apellido2 from alumno where sexo='M';

-- 7) Calcula cuántos alumnos nacieron en 1999.
select count(*) as Cantidad_alumnos from alumno where year(fecha_nacimiento)=1999;
select nombre,count(*) as Cantidad_alumnos from alumno where year(fecha_nacimiento)=1999 group by nombre;

-- 8) Calcula cuántos profesores hay en cada departamento. 
-- El resultado sólo debe mostrar dos columnas, una con el nombre del departamento
-- y otra con el número de profesores que hay en ese departamento. 
-- El resultado sólo debe incluir los departamentos que tienen profesores
-- asociados y deberá estar ordenado de mayor a menor por el número de profesores.

select d.nombre , count(id_departamento) as Cantidad_profesores from profesor p inner join departamento d  
on p.id_departamento=d.id group by nombre order by count(id_departamento) desc ;


-- 9) Devuelve un listado con todos los departamentos y el número de
-- profesores que hay en cada uno de ellos. Tenga en cuenta que 
-- pueden existir departamentos que no tienen profesores asociados.
-- Estos departamentos
-- también tienen que aparecer en el listado.


select d.nombre, count(id_departamento) as Cantidad_profesores from profesor p right join departamento d 
on p.id_departamento=d.id  group by nombre  ;


-- 10) Devuelve un listado con el nombre de todos los grados existentes en la base de 
-- y el número de asignaturas que tiene cada uno. 
-- Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas.
-- Estos grados también tienen que aparecer en el listado. 
-- El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

select nombre from grado;
select grado.nombre, count(id_grado) as cantidad_asignatura from grado  left join asignatura 
on grado.id = asignatura.id_grado group by nombre order by count(id_grado) desc;

-- 11) Devuelve un listado con el nombre de todos los grados existentes en la base de datos 
-- y el número de asignaturas que tiene cada uno, de los grados que tengan más de 
-- 40 asignaturas asociadas.

select grado.nombre, count(id_grado) as cantidad_asignatura from grado left join asignatura 
on grado.id = asignatura.id_grado  group by nombre having count(id_grado)>40 ;



-- 12) Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos
-- que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado,
-- tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo.
-- Ordene el resultado de mayor a menor por el número total de crédidos.

select g.nombre ,a.tipo as Tipo_asignatura,sum(a.creditos)as Suma_creditos from grado g inner join asignatura a 
on g.id=a.id_grado group by nombre, tipo order by count(creditos) desc;

-- 13) Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura
-- en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas,
-- una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.

select c.anyo_inicio as año_inicio ,  count(am.id_alumno) as total_alumnos_matriculados from  alumno_se_matricula_asignatura  am 
inner join curso_escolar c on am.id_curso_escolar =  c.id  group by anyo_inicio;

-- 14) Devuelve un listado con el número de asignaturas que imparte cada profesor.
-- El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura.
-- El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas.
-- El resultado estará ordenado de mayor a menor por el número de asignaturas.

select p.id as Id, p.nombre as Nombre, p.apellido1 as Apellido_1, p.apellido2 as Apellido_2, count(a.id_profesor) as Numero_de_asignaturas 
from profesor p left join asignatura a on p.id = a.id_profesor group by id order by count(a.id_profesor) desc ;