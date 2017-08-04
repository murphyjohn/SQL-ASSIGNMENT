--Request 10
--List the department number, department name and the number of
--employees for the department that has the highest number of employees using appropriate grouping.

select TOP 1 d.Department_No, Department_Name, COUNT(*) as Total_Employees
from Departments d, Employees e
	where d.Department_No=e.Department_No
group by Department_Name, d.Department_No
having COUNT(*) > 2
order by Total_Employees Desc
