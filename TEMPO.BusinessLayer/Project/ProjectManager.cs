﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TEMPO.Data;

namespace TEMPO.BusinessLayer.Project
{
    public class ProjectManager : BaseManager
    {
        public List<Data.Project> GetProjects()
        {
            return DataContext.Projects.ToList();
        }

        public List<Data.Project> GetProjects(int clientId)
        {
            return DataContext.Projects.Where(i => i.clientid == clientId).ToList();
        }

        public List<Data.ProjectSummary> GetProjectSummaries(int clientId)
        {
            return DataContext.ProjectSummaries.Where(i => i.clientid == clientId).ToList();
        }


        public Data.Project GetProject(int projectId)
        {
            return DataContext.Projects.Where(i => i.projectid == projectId).FirstOrDefault();
        }

        public List<Data.JobYear> GetJobYears()
        {
            return DataContext.JobYears.ToList();
        }

        public List<Data.ProjectType> GetProjectTypes()
        {
            return DataContext.ProjectTypes.ToList();
        }

        public Data.Project Create(int clientId, int jobYearId, string projectNumber, string refNumber, int typeId, string description, float? amount)
        {
            var newProject = new Data.Project
            {
                clientid = clientId,
                Active = true,
                description = description,
                jobnum = projectNumber,
                jobnumyear = jobYearId,
                refjobnum = refNumber,
                projecttypeid = typeId,
                contractamount = (decimal) amount
            };
            DataContext.Projects.Add(newProject);
            DataContext.SaveChanges();
            return newProject;
        }
    }
}
