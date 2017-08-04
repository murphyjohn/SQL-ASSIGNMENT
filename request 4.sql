--Request 4
--List the last name, first name, job id and commission of employees who earn
--commission sorted in ascending order of first name within last name.

select Last_Name, First_Name, Job_ID, Commission_Percent
from Employees
where Commission_Percent > 0
order by Last_Name ASC, First_Name Asc
