-- List the teachers who have null for their department.

select name
from teacher
where dept is null

-- Note the inner join misses the teachers with no department and the departments with no teacher.


select teacher.name, dept.name
 from teacher inner join dept
           on (teacher.dept=dept.id)

-- Use a different join so that all teachers are listed.


select teacher.name, dept.name
from teacher left join dept
          on (teacher.dept=dept.id)

--Use a different join so that all departments are listed.

select teacher.name, dept.name
from teacher right join dept
          on (teacher.dept=dept.id)

--Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'

select name,
coalesce(mobile, '07986 444 2266')
from teacher

-- Use the COALESCE function and a left join to print the teacher name and department name. Use the string 'None' where there is no department.
select coalesce(teacher.name, 'NonE'), coalesce(dept.name, 'None')
from teacher left join dept on (teacher.dept=dept.id)

-- Use COUNT to show the number of teachers and the number of mobile phones.
select count(name), count(mobile)
from teacher

-- Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT join to ensure that the Engineering department is listed.
select dept.name, count(teacher.name)
from teacher right join dept on (teacher.dept=dept.id)
group by dept.name

-- Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
select teacher.name,
case when dept.id = 1 then 'Sci'
     when dept.id = 2 then 'Sci'
     else 'Art' end
from teacher left join dept on (teacher.dept=dept.id)

-- Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
select teacher.name,
case
when dept.id = 1 then 'Sci'
when dept.id = 2 then 'Sci'
when dept.id = 3 then 'Art'
else 'None' end
from teacher left join dept on (dept.id=teacher.dept)