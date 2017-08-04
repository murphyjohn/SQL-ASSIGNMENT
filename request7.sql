--Request 7
--Show the total salaries figure for one month displayed with no decimal places.

select CAST((SUM(Annual_Salary)/12) as int) as Monthly_Salary_Total
from Employees