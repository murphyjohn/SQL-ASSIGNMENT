--Request 3
--List all the data for all jobs where the maximum salary is greater than 15000
--sorted in descending order of the maximum salary.

select * 
from Jobs
where Max_Salary>15000
order by Max_Salary DESC
