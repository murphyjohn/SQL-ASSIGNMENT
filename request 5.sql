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
