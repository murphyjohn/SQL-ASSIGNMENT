--Request 17
--Create a new view for managerís details only using all the fields from the
--employee table. Apply a CHECK constraint.

create view Manager_Details as
select * from 
	Employees

	where Job_ID like'%MGR%'
	and
	Manager_ID = Employee_No

