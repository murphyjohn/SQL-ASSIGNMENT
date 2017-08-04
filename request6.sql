--Request 6
--List the last name of all employees in departments 50 and 90 together with their
--monthly salaries (rounded to 2 decimal places), sorted in ascending order of last name.

select Last_Name, CAST(ROUND((Annual_Salary/12),2) as money) as Monthly_Salary
from Employees
where Department_No = 50
	or Department_No = 90
order by Last_Name ASC