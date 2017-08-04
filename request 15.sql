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
