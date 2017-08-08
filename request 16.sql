--Request 16
--Produce a list of employees showing percentage raises, employee numbers
--and old and new salaries. Employees in departments 20 and 10 are given a 5% rise,
--employees in departments 50, 80, 90 and 110 are given a 10% rise
--and employees in other departments are not given a rise.

select Employee_No, 
Annual_Salary Old_Salary,
	case
	when Department_No in (20, 10) then Annual_Salary*1.05
	when Department_No in (50, 80, 90, 110) then Annual_Salary*1.10
	else Annual_Salary
	end as New_Salary,
	
	case
	when Department_No in (20, 10) then '5%'
	when Department_No in (50, 80, 90, 110) then '10%'
	else '0%'
	end as Percentage_Raise,

Department_No
from Employees
order by Department_No
