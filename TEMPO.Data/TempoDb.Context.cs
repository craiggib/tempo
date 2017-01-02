﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TEMPO.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class TempoDbContext : DbContext
    {
        public TempoDbContext()
            : base("name=TempoDbContext")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Client> Clients { get; set; }
        public virtual DbSet<Employee> Employees { get; set; }
        public virtual DbSet<JobYear> JobYears { get; set; }
        public virtual DbSet<MiscTimeLog> MiscTimeLogs { get; set; }
        public virtual DbSet<Module> Modules { get; set; }
        public virtual DbSet<PeriodEnding> PeriodEndings { get; set; }
        public virtual DbSet<Project> Projects { get; set; }
        public virtual DbSet<ProjectType> ProjectTypes { get; set; }
        public virtual DbSet<Status> Status { get; set; }
        public virtual DbSet<TimeEntry> TimeEntries { get; set; }
        public virtual DbSet<TimeSheet> TimeSheets { get; set; }
        public virtual DbSet<WorkType> WorkTypes { get; set; }
        public virtual DbSet<ClientSummary> ClientSummaries { get; set; }
        public virtual DbSet<ProjectBillableHour> ProjectBillableHours { get; set; }
        public virtual DbSet<ProjectSummary> ProjectSummaries { get; set; }
        public virtual DbSet<Quote> Quotes { get; set; }
    }
}
