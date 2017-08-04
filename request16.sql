--Request 16
--Produce a list of employees showing percentage raises, employee numbers
--and old and new salaries. Employees in departments 20 and 10 are given a 5% rise,
--employees in departments 50, 80, 90 and 110 are given a 10% rise
--and employees in other departments are not given a rise.
use CGDatabase

select distinct
		First_Name, Last_Name, Employee_No, Annual_Salary as Old_Salary,
		Round((Annual_Salary*1.05),2) as New_Salary, '5%' as Raise
		 
from Employees e, Departments d
where e.Department_no = d.Department_no
and
    e.Department_No = 10
	or
	e.Department_No=20

union 
 select distinct
		First_Name, Last_Name, Employee_No, Annual_Salary as Old_Salary,
		Round((Annual_Salary*1.10),2) as New_Salary, '10%' as Raise
		 
from Employees e, Departments d
where e.Department_no = d.Department_no
and
    e.Department_No = 50
	or
	e.Department_No=80
	or
	e.Department_No=90
	or 
	e.Department_No=110
union 
 select distinct
		First_Name, Last_Name, Employee_No, Annual_Salary as Old_Salary,
		Annual_Salary as New_Salary, '0%' as Raise
		from Employees e, Departments d
where e.Department_no = d.Department_no
and
    e.Department_No!= 50
	and
	e.Department_No!=80
	and
	e.Department_No!=90
	and 
	e.Department_No!=110
	and
	e.Department_No!=20
	and
	e.Department_No!=10

