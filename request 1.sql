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
