USE [TEMPO]
GO
/****** Object:  View [tempo_user].[ProjectList]    Script Date: 04/12/2007 20:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [ProjectList]

as

select 
	substring(cast(jobyear as char(4)), 3, 2) + '-' + 	
	cast(jobnum as varchar(10) ) + ' ' + cast([description] as varchar(30))
	
	as ProjectName, 
projectid, clientid, jobnumyear, jobnum, refjobnum, projecttypeid, [description] from project, jobyear
where project.jobnumyear = jobyear.jobyearid

