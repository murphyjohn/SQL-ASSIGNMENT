--Request 9
--List the department number, department name and the number of
--employees for each department that has more than 2 employees 
--grouping by department number and department name.

select d.Department_No, Department_Name, COUNT(*) as Total_Employees
from Departments d, Employees e
	where d.Department_No=e.Department_No
group by Department_Name, d.Department_No
having COUNT(*) > 2