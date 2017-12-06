--Request 1
--List the last name, first name and employee number of all employees that 
--have a last name starting with M.
use CGDatabase
Select Last_Name, First_Name, Employee_No from dbo.Employees
where Last_Name like 'M%'


--Request 2
--List the department number, last name, first name and phone number of all sales 
--representatives who were hired on or after 24 Mar 1998 sorted in ascending order of last name.
use CGDatabase
select Department_No, First_Name, Last_Name, Phone_Number 
from employees e, Jobs j
where e.Job_ID = j.Job_ID
and Hire_Date > '1998-03-23'
and Job_Title = 'Sales Representative'
order by Last_Name ASC


--Request 3
--List all the data for all jobs where the minimum salary is less than or 
--equal to 4500 sorted in descending order of the minimum salary.
use CGDatabase
select * from Jobs 
where Min_Salary <= 4500
order by Min_Salary DESC


--Request 4
--Which jobs are found in the Marketing and Accounting departments?
use CGdatabase

select Job_Title from Jobs j, Employees e, Departments d
where j.Job_ID = e.Job_ID
and d.Department_No = e.Department_No
and (Department_Name = 'Marketing' or Department_Name = 'Accounting')


--Request 5
--List the department name, location, last name and salary of employees who 
--work in location 1700 sorted in ascending order of department name.
use CGDatabase
select Department_Name, City, Locations.Location_ID, Last_Name, Annual_Salary 

from Employees
	join Departments 
		on Employees.Department_No = Departments.Department_No
	join Locations
		on Departments.Location_ID = Locations.Location_ID

where 
Locations.Location_ID  = 1700



--Request 6
--List the last name and first name for all employees who were hired in 
--the months of June or August (for all years) sorted in ascending order of last name.

use CGDatabase

select Last_Name, First_Name
from Employees
where 
	MONTH(Hire_Date)=6
	or
	MONTH(Hire_Date)=8

order by Last_Name ASC



--Request 7
--Show the average salary for employees for one year (rounded to 2 decimal places).
use CGDatabase

select ROUND(AVG(CAST(Annual_Salary AS MONEY)),2) 
from Employees



--Request 8
--Show the total monthly salaries figure (0 decimal places) for all employees 
--in departments 80 and 60.
use CGDatabase

select 
	ROUND(CAST(SUM(Annual_Salary/12) as int),0) as "Total_Monthly_Salary"
from 
	Employees
where 
	Department_No = 60
	or 
	Department_No = 80



--Request 9
--List the department number, department name and the number of employees 
--for each department that has less than 4 employees grouping by department number 
--and department name.

use CGDatabase

select Departments.Department_No, Departments.Department_Name, Emp_Num
   
   from Departments
	join(
		select Department_No,
		COUNT(Employee_No) as Emp_Num
		from Employees
		group by Department_No
	)
	as Emp1
	on Emp1.Department_No = Departments.Department_No

	where Emp_Num < 4
	
	group by Departments.Department_No, Department_Name, Emp_Num



--Request 10
--List the department number, department name and the number of employees for 
--the department that has the lowest number of employees using appropriate grouping.

use CGDatabase


select Departments.Department_No, Department_Name, Emp_Num
from Departments
join (
	select Department_No,
		COUNT(Employee_No) as Emp_Num
		from Employees
		group by Department_No
	) as Emp1
on Emp1.Department_No = Departments.Department_No
where Emp_Num = (
	select Min(Emp_Num) as Min_Emp
	from Departments
	join (
		select Department_No, count(*)as Emp_Num
		from Employees
		group by Department_No
	) as Empl
	on Empl.Department_No = Departments.Department_No
)
group by Departments.Department_No, Department_Name, Emp_Num



--Request 11
--List the department number and name for all departments where no sales representatives work.
use CGDatabase

select Departments.Department_No, Department_Name

from 
	Departments
	join Employees
		on Employees.Department_No=  Departments.Department_No

where Department_Name <> 'Sales'

group by Departments.Department_No, Department_Name

--Request 11 Proper Method.
select distinct d.Department_Name, d.Department_No from Departments d, Jobs j, Employees e
where d.Department_No = e.Department_No
and j.Job_ID = e.Job_ID
and d.Department_No NOT IN(
	Select d.Department_No from Departments d, Jobs j, Employees e
	where d.Department_No = e.Department_No
	and j.Job_ID = e.Job_ID 
	and job_title = 'Sales Representative')


--Request 12
--Add the following new job
--IT_ASST, IT Assistant, 5000, 8000


use CGDatabase

insert into Jobs(Job_ID, Job_Title, Min_Salary,Max_Salary)
	values('IT_ASST', 'IT Assistant', 5000, 8000)



--Request 13
--Update all the minimum salaries for jobs with an increase of 500.

use CGDatabase

update Jobs 
set Min_Salary = (Min_Salary+500)



--Request 14
--List all the data for jobs sorted in ascending order of job id.

use CGDatabase

select * from Jobs
order by Job_ID ASC



--15.


 
--Request 16
--Print a copy of the data dictionary entry for the table departments.

use CGDatabase

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

where TABLE_NAME = 'Departments'



--Request 17
--Drop the table for job history.

drop table Job_History



--Request 18
--Create a new table called SAL_HISTORY to include the fields 
--EMPID, FIRSTNAME, LASTNAME, HIREDATE and SAL with the 
--same data types as the employees table. The EMPID must not be NULL.

CREATE TABLE SAL_HISTORY(
	Emp_ID int not null, 
	First_Name varchar(20),
	 Last_Name varchar(25), 
	 Hire_Date datetime,
	 Annual_Salary decimal(8,2)
	 )



--Request 19
--Insert data from the employees table where the employee number is less than or
-- equal to 130 into the SAL_HISTORY table.

INSERT INTO SAL_HISTORY (Emp_ID, First_Name, Last_Name, Hire_Date, Annual_Salary)
SELECT Employee_No, First_Name, Last_Name, Hire_Date, Annual_Salary
FROM Employees
where Employee_No < 130




--Request 20
--Display all the records and all the fields in the SAL_HISTORY table.

select * from SAL_History
