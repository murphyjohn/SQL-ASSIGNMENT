
--Request 1
--List the last name, first name and employee number of 
--all employees that have a last name starting with S.

select Last_Name, First_Name, Employee_No
from Employees
where Last_Name like 'S%'


--Request 2
--List the last name, first name and employee number of all stock clerks
-- who were hired on or before 26 Aug 1998 sorted in ascending order of last name.

select 
	Last_Name, First_Name, Employee_No
from 
	Employees, Jobs
where 
	Employees.Job_ID = Jobs.Job_ID
and
	Job_Title = 'Stock Clerk'
and
	Hire_Date <= '26-AUG-1998'

order by Last_Name ASC


--Request 3
--List the department number, last name and salary of 
--all employees who were hired between 15/11/98 and 07/12/99 
--sorted in ascending order of last name within department number.

select Department_No, Last_Name, Annual_Salary
from Employees 
where 
	Hire_Date between '15-Nov-1998' and '07-DEC-1999'
order by Department_No, Last_Name ASC



--Request 4
--List the last name, job and commission percentage of employees
--where the commission percentage is less than or equal 15% 
--sorted in descending order of commission percentage.

select Last_Name, Job_Title, Commission_Percent
from Employees e, Jobs j
	where e.Job_ID = j.Job_ID
	and Commission_Percent <= 0.15
order by Commission_Percent DESC






--Request 5
--Which jobs are found in the Administration and Human Resources departments?

select distinct Job_Title
from Jobs j , Employees e, Departments d
where 
	j.Job_ID=e.Job_ID
	AND
		e.Department_No = d.Department_No
	and
		(Department_Name = 'Administration'
		or
		Department_Name = 'Human Resources')




--Request 6
--List the last name of all employees in the Marketing and Sales departments
--together with their monthly salaries (rounded to 2 decimal places), 
--sorted in ascending order of last name.

select 
	--Last_Name, CAST((ROUND((Annual_Salary/12),2)) as money) as Monthly_Salary
	Last_Name, (ROUND((Annual_Salary/12),2)) as Monthly_Salary
from 
	Employees e, Departments d
where
		e.Department_No=d.Department_No
	and(
		Department_Name='Marketing'
		or
		Department_Name='Sales'
	  )
order by Last_Name ASC



--Request 7
--Show the average salaries figure for one month displayed with no decimal places.

select 
	CAST(AVG(((Annual_Salary)/12)) as int) as Avg_Monthly_Salary
from Employees



--Request 8
--Show the total number of employees in the Finance department.

select 
	count(*) as Finance_Emps
from Employees e, Departments d
	where 
		e.Department_No = d.Department_No
		and
		Department_Name = 'Finance'




--Request 9
--List the last name, first name, hire date and salary of all employees
-- in the UK sorted in ascending order of last name.

select 
	Last_Name, First_Name, Hire_Date, Annual_Salary
from
	Employees e, Departments d, Locations l
	where 
		e.Department_No = d.Department_No
	and
		d.Location_ID = l.Location_ID
	and
		l.Country_ID = 'UK'
order by Last_Name


--Request 10
--List the department number, and the highest salary of 
--the department with the highest average salary.

select TOP 1
	Department_No, 
	Annual_Salary as Highest_Salary

from Employees e
Group by E.Department_No, e.Annual_Salary
order by AVG(Annual_Salary) Desc



--Request 11
--List the department number and name for all departments 
--where no marketing representatives work.

select distinct d.Department_Name, d.Department_No
from Departments d, Employees e
Group by d.Department_No, d.Department_Name
except 
	(select distinct d.Department_Name,e.Department_No 
		from Departments d, Employees e, Jobs j
		where j.Job_ID = e.Job_ID
		and Job_Title = 'Marketing Representative')


--Request 12
--Add the following new job
--SA_CLERK, Sales Clerk, 9000, 12000

insert into jobs (Job_ID, Job_Title, Min_Salary, Max_Salary)
values ('SA_CLERK', 'Sales Clerk', 9000, 12000)



--Request 13
--Update all the maximum salaries for jobs with an increase of 2000.

update Jobs
set Max_Salary=(Max_Salary+2000)



--Request 14
--List all the data for jobs sorted in ascending order of maximum salary.

select * from jobs
order by Max_Salary ASC



--Request 15
--Produce a list of employees showing percentage raises, employee numbers 
--and old and new salaries. 
--Employees in departments 80 and 90 are given a 6% rise, 
--employees in departments 20 and 190 are given a 12% rise and 
--employees in other departments are not given a rise.

select 
	Department_No,
	Employee_No, 
	Annual_Salary Old_Salary,
	case
		when Department_No in (80, 90) then Annual_Salary*1.06
		when Department_No in (20, 190) then Annual_Salary*1.12
		else Annual_Salary
	end 
	as New_Salary,
	case
		when Department_No in (80, 90) then '6%'
		when Department_No in (20, 190) then '12%'
		else '0%'
	end as 
	Percentage_Raise

from Employees
order by Department_No


--Request 17
--Create a new view for manager’s details only using 
--all the fields from the employee table.
--Show all the fields and all the managers using the view for managers.

Create view ManagerDetails
as select * from Employees
	where Employee_No = Manager_ID
select * from ManagerDetails



--Request 18
--a) Drop the manager’s view.
--b) Recreate the manager’s view so that the 
--salary field is no longer included.
--c) Use the ALTER statement to compile the manager’s view.

--a)
Drop view Manager_Details

--b)
Create view Manager_Details
as select Employee_No,
 First_Name,
 Last_Name,
 Email,
 Phone_Number,
 Hire_Date, 
 Job_ID,
 Commission_Percent,
 Manager_ID,
 Department_No
from Employees 
where Employee_No = Manager_ID

--c)
Alter view Manager_Details
as select Employee_No,
 First_Name,
 Last_Name,
 Email,
 Phone_Number,
 Hire_Date, 
 Job_ID,
 Commission_Percent,
 Manager_ID,
 Department_No
from Employees 
where Employee_No = Manager_ID
	


--Request 19
--Show all the fields and all the managers using the view for managers.

select * from Manager_Details




--Request 20
--Print a copy of the data dictionary entry for the table employees

USE CGDatabase
-- =============================================
-- Author:JOHIR
-- Create date: 01/12/2012
-- Description:	GENERATE DATA DICTIONARY FROM SQL SERVER
-- =============================================

BEGIN

select a.name [Table],b.name [Attribute],c.name [DataType],b.isnullable [Allow Nulls?],CASE WHEN 
d.name is null THEN 0 ELSE 1 END [PKey?],
CASE WHEN e.parent_object_id is null THEN 0 ELSE 1 END [FKey?],CASE WHEN e.parent_object_id 
is null THEN '-' ELSE g.name  END [Ref Table],
CASE WHEN h.value is null THEN '-' ELSE h.value END [Description]
from sysobjects as a
join syscolumns as b on a.id = b.id
join systypes as c on b.xtype = c.xtype 
left join (SELECT  so.id,sc.colid,sc.name 
      FROM    syscolumns sc
      JOIN sysobjects so ON so.id = sc.id
      JOIN sysindexkeys si ON so.id = si.id 
                    and sc.colid = si.colid
      WHERE si.indid = 1) d on a.id = d.id and b.colid = d.colid
left join sys.foreign_key_columns as e on a.id = e.parent_object_id and b.colid = e.parent_column_id    
left join sys.objects as g on e.referenced_object_id = g.object_id  
left join sys.extended_properties as h on a.id = h.major_id and b.colid = h.minor_id
where a.type = 'U' order by a.name

END