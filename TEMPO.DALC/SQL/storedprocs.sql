create proc [DeleteUserRoles]
@empid int
as
delete from moduleauth where empid = @empid

GO

create proc [GetAllRoles]
as
select * from module

GO 

CREATE PROCEDURE [GetEmployee]
	-- Add the parameters for the stored procedure here
	@employeename varchar(255),
	@password varchar(15)
AS
BEGIN
	
	select * from Employee where employeename = @employeename and password = @password;
END
GO

create proc [GetInCompletePeriodEndingByRange]
	@From DateTime,
	@To DateTime,
	@Employeeid int
	
as

select PEID, 
cast(DATEPART(m, endingdate) as varchar(2)) + '/' 
	+ cast(DATEPART(d, endingdate) as varchar (2)) + '/' 
	+  cast(DATEPART(yy, endingdate) as varchar(4))
	as EndingDate
 from PeriodEnding where Endingdate between @From and @To
and PEID not in (select PEID from TimeSheet where empid = @EmployeeID)

GO

create proc [GetSavedRejectedTimeSheets] 
	@Employeeid int

as

select tid,timesheet.peid,timesheet.empid,timesheet.statusid,notes,endingdate,statusname,employeename,

cast(DATEPART(m, endingdate) as varchar(2)) + '/' 
+ cast(DATEPART(d, endingdate) as varchar (2)) + '/' 
+  cast(DATEPART(yy, endingdate) as varchar(4)) + ' ' 
+ cast (statusname as varchar(9)) as TimeSheetName

from timesheet, status, periodending,employee 
where timesheet.statusid = status.statusid and timesheet.peid = periodending.peid
and employee.empid = timesheet.empid 
and (status.statusname = 'Saved' or status.statusname = 'Rejected') and timesheet.empid = @EmployeeID

select entryid, timeentry.tid, sunday,monday,tuesday,wednesday,thursday,friday,saturday,
worktypeid,timeentry.projectid,client.clientid
from timesheet, status, employee, timeentry, client, project
where timesheet.statusid = status.statusid
and employee.empid = timesheet.empid
and (status.statusname = 'Saved' OR status.statusname = 'Rejected')
and timesheet.empid = @EmployeeID
and timesheet.tid = timeentry.tid
and project.projectid = timeentry.projectid
and project.clientid = client.clientid

GO

CREATE proc [GetUserRoles]
@empid int
as
select * from module
select moduleid, empid from moduleauth where empid = @empid

GO

create proc [InsertUserIntoRole]
@empid int, @moduleid int
as 
insert into moduleauth (moduleid, empid) values (@moduleid, @empid)

GO
CREATE  proc [EmployeeTimeSheetReport]
	@tid int

as

SELECT     dbo.timesheet.tid, dbo.timeentry.sunday, dbo.timeentry.monday, dbo.timeentry.tuesday, dbo.timeentry.wednesday, dbo.timeentry.thursday, 
                      dbo.timeentry.friday, dbo.timeentry.saturday, dbo.client.clientname, dbo.project.jobnumyear, dbo.project.refjobnum, dbo.periodending.endingdate, 
                      dbo.employee.employeename, dbo.timeentry.entryid, 
substring(cast(jobyear as char(4)), 3, 2) + '-' + 	
	cast(jobnum as varchar(10) ) + ' ' + cast([description] as varchar(30))
	
	as ProjectName

FROM         dbo.timesheet INNER JOIN
                      dbo.timeentry ON dbo.timesheet.tid = dbo.timeentry.tid INNER JOIN
                      dbo.periodending ON dbo.timesheet.peid = dbo.periodending.peid INNER JOIN
                      dbo.worktype ON dbo.timeentry.worktypeid = dbo.worktype.worktypeid INNER JOIN
                      dbo.project ON dbo.timeentry.projectid = dbo.project.projectid INNER JOIN
                      dbo.client ON dbo.project.clientid = dbo.client.clientid INNER JOIN
                      dbo.employee ON dbo.timesheet.empid = dbo.employee.empid INNER JOIN
			jobyear on project.jobnumyear = jobyear.jobyearid
WHERE     (dbo.timesheet.tid = @tid)
GO
create proc [GetJobYears]
	
as

select * from JobYear order by JobYear

GO
create proc [GetSubmittedTimeSheets]
as

select tid,timesheet.peid,timesheet.empid,timesheet.statusid,notes,endingdate,statusname,employeename,
cast(DATEPART(m, endingdate) as varchar(2)) + '/' 
+ cast(DATEPART(d, endingdate) as varchar (2)) + '/' 
+  cast(DATEPART(yy, endingdate) as varchar(4)) + ' ' 
+ cast (employeename as varchar(30)) as TimeSheetName
from timesheet, status, periodending,employee

where timesheet.statusid = status.statusid and timesheet.peid = periodending.peid
and employee.empid = timesheet.empid
and status.statusname = 'Submitted';


select entryid, timeentry.tid, sunday,monday,tuesday,wednesday,thursday,friday,saturday,
worktypeid,timeentry.projectid,client.clientid
from timesheet, status, employee, timeentry, client, project
where timesheet.statusid = status.statusid
and employee.empid = timesheet.empid
and status.statusname = 'Submitted'
and timesheet.tid = timeentry.tid
and project.projectid = timeentry.projectid
and project.clientid = client.clientid;
