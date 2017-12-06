--Request 1
--List the last name, first name and employee number of all programmers who
--were hired on or before 21 May 1991 sorted in ascending order of last name.

select Last_Name, First_Name, Employee_No
from Employees, Jobs
where Employees.Job_ID = Jobs.Job_ID
and 
Job_Title= 'Programmer'
and
Hire_Date <= '05-21-1991'
order by Last_Name ASC

--Request 2
--List the department number, last name and salary of all employees who were
--hired between 16/09/87 and 12/05/96 sorted 
--in ascending order of last name within department number.

select Department_No, Last_Name, Annual_Salary
from Employees
where 
	Hire_Date between '16-SEP-1987' and '12-MAY-1996'
order by  Department_No ASC,Last_Name ASC

--Request 3
--List all the data for all jobs where the maximum salary is greater than 15000
--sorted in descending order of the maximum salary.

select * 
from Jobs
where Max_Salary>15000
order by Max_Salary DESC


--Request 4
--List the last name, first name, job id and commission of employees who earn
--commission sorted in ascending order of first name within last name.

select Last_Name, First_Name, Job_ID, Commission_Percent
from Employees
where Commission_Percent > 0
order by Last_Name ASC, First_Name Asc


--Request 5
--Which jobs are found in the IT and Sales departments?


Select Distinct Job_Title, Department_Name
From Jobs j, Employees e, Departments d
Where 
	(Department_Name= 'IT' OR Department_Name='Sales')
	AND
	d.Department_No= e.Department_No
	AND
	j.Job_ID= e.Job_ID


--Request 6
--List the last name of all employees in departments 50 and 90 together with their
--monthly salaries (rounded to 2 decimal places), sorted in ascending order of last name.

select Last_Name, CAST(ROUND((Annual_Salary/12),2) as money) as Monthly_Salary
from Employees
where Department_No = 50
	or Department_No = 90
order by Last_Name ASC


--Request 7
--Show the total salaries figure for one month displayed with no decimal places.

select CAST((SUM(Annual_Salary)/12) as int) as Monthly_Salary_Total
from Employees


--Request 8
--Show the total number of employees.

select COUNT(*) as Total_Employees from Employees 


--Request 9
--List the department number, department name and the number of
--employees for each department that has more than 2 employees 
--grouping by department number and department name.

select d.Department_No, Department_Name, COUNT(*) as Total_Employees
from Departments d, Employees e
	where d.Department_No=e.Department_No
group by Department_Name, d.Department_No
having COUNT(*) > 2


--Request 10
--List the department number, department name and the number of
--employees for the department that has the highest number of employees using appropriate grouping.

select TOP 1 d.Department_No, Department_Name, COUNT(*) as Total_Employees
from Departments d, Employees e
	where d.Department_No=e.Department_No
group by Department_Name, d.Department_No
having COUNT(*) > 2
order by Total_Employees Desc


--Request 11
--List the department number and name for all departments where no
--programmers work.

Use CGDatabase

select distinct d.Department_Name, d.Department_No
from Departments d, Employees e
Group by d.Department_No, d.Department_Name
except 
	(select d.Department_Name,e.Department_No from Departments d, Employees e, Jobs j
		where j.Job_ID = e.Job_ID
		and Job_Title = 'Programmer')


--Request 12
--Add the following new job
--IT_ANAL, System Analyst, 10000, 15000

insert into Jobs (Job_ID, Job_Title, Min_Salary, Max_Salary)
values ('IT_ANAL', 'System Analyst', 10000, 15000)


--Request 13
--Update all the maximum salaries for jobs with an increase of 1000.

update Jobs
set Max_Salary = (Max_Salary+1000)


--Request 14
--List all the data for jobs sorted in ascending order of job id.

select * from jobs
order by Job_ID


--Request 15
--a) The job history for employee number 102 is no longer required.
--Delete this record.
--b) List all the data for job history sorted in ascending order of
--employee number.

--a
delete from Job_History
where Employee_No = 102

--b
select * from Job_History
order by Employee_No ASC


--Request 16
--Produce a list of employees showing percentage raises, employee numbers
--and old and new salaries. Employees in departments 20 and 10 are given a 5% rise,
--employees in departments 50, 80, 90 and 110 are given a 10% rise
--and employees in other departments are not given a rise.

select 
	Employee_No, 
	Department_No,
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
	end as Percentage_Raise
from Employees
order by Department_No

--Request 17
--Create a new view for manager’s details only using all the fields from the
--employee table. Apply a CHECK constraint.

create view Manager_Details as
select * from 
	Employees

	where Job_ID like'%MGR%'
	and
	Manager_ID = Employee_No
with check option


--Request 18
--Show all the fields and all the managers using the view for managers sorted
--in ascending order of employee number.

select * from Manager_Details
order by Employee_No ASC


--Request 19
--Grant the authority to all other users to access the view for managers for
--SELECT statements only.

grant select on Manager_Details to public


--Request 20
--Create an index named LOC_POSTAL_CODE on the Postal Code in the
--locations table.
--Provide a printout showing that the index has been created.
create index LOC_POSTALCODE on Locations(Postal_Code)






