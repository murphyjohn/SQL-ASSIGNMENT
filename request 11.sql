--Request 11
--List the department number and name for all departments where no
--programmers work.

Use CGDatabase

select distinct d.Department_Name, d.Department_No
from Departments d, Employees e
Group by d.Department_No, d.Department_Name
except 
	(select d.Department_Name,e.Department_No from Departments d, Employees e, Jobs j
		where j.Job_ID = e.Job_ID
		and Job_Title = 'Programmer')
