--Request 11
--List the department number and name for all departments where no
--programmers work.

select distinct d.Department_No, Department_Name
from Departments d, Employees e, Jobs j
where d.Department_No=e.Department_No
and 
	e.Job_ID = j.Job_ID
and	
	Job_Title='Programmer'
