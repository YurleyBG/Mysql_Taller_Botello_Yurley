USE universidad_T2;

-- 1) Devuelve todos los datos del alumno más joven.

select *, 2024-year(fecha_nacimiento) as edad from alumno group by 1,2 order by 2024-year(fecha_nacimiento) asc limit 1 ;

-- 2) Devuelve un listado con los profesores que no están asociados a un departamento

select id_departamento, nombre from profesor where id_departamento is null;

-- 3) Devuelve un listado con los departamentos que no tienen profesores asociados.

select d.nombre  from departamento d left join profesor p  on d.id = p.id_departamento where p.id_departamento is null group by 1 ;


-- 4) Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

select profesor.nombre from profesor inner join departamento  on profesor.id_departamento = departamento.id  
left join asignatura a  on profesor.id = a.id_profesor where a.id_profesor is null  ;

-- 5) Devuelve un listado con las asignaturas que no tienen un profesor asignado.

select distinct a.nombre , id_profesor from  asignatura a inner join profesor p  where a.id_profesor is null;

-- 6) Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.

select distinct departamento.nombre from departamento,profesor,asignatura,alumno_se_matricula_asignatura,curso_escolar 
where not  departamento.id=profesor.id_departamento and  asignatura.id_profesor = profesor.id ;

-- 7) Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura
-- en el Grado en Ingeniería Informática (Plan 2015).

select  departamento.nombre from departamento 
inner join profesor on departamento.id = profesor.id_departamento 
inner join asignatura on asignatura.id_profesor = profesor.id 
inner join grado  on asignatura.id_grado = grado.id ;

-- 8)  Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados.
-- El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado.
-- El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.

select  d.nombre,profesor.apellido1,profesor.apellido2, profesor.nombre  from profesor  
left join departamento d on profesor.id_departamento=d.id order by 1,2,3,4 asc;

-- 9) Devuelve un listado con los profesores que no están asociados a un departamento.

select id_departamento, nombre from profesor where id_departamento is null;

-- 10) Devuelve un listado con los profesores que no imparten ninguna asignatura.
select profesor.nombre, profesor.apellido1,profesor.apellido2 from profesor  
left join asignatura a  on profesor.id = a.id_profesor where a.id_profesor is null  order by 1 asc;


-- 11) Devuelve un listado con las asignaturas que no tienen un profesor asignado.
select distinct a.nombre , id_profesor from  asignatura a inner join profesor p  where a.id_profesor is null;

-- 12) Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido 
-- en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre 
-- de la asignatura que no se haya impartido nunca.

select distinct departamento.nombre, asignatura.nombre from departamento 
inner join profesor on departamento.id = profesor.id_departamento 
inner join asignatura on asignatura.id_profesor = profesor.id 
inner join alumno_se_matricula_asignatura am  inner join curso_escolar c on am.id_curso_escolar=c.id ;
