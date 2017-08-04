--Request 2
--List the department number, last name and salary of all employees who were
--hired between 16/09/87 and 12/05/96 sorted 
--in ascending order of last name within department number.

select Department_No, Last_Name, Annual_Salary
from Employees
where 
	Hire_Date between '16-SEP-1987' and '12-MAY-1996'
order by  Department_No ASC,Last_Name ASC