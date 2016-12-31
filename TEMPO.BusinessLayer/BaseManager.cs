﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TEMPO.Data;

namespace TEMPO.BusinessLayer
{
    public abstract class BaseManager
    {

        protected TempoDbContext DataContext { get; private set; }

        public BaseManager()
        {
            DataContext = new TempoDbContext();
        }
        
    }
}
