using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Models
{
    public class Employee : IdToName
    {
        public string Profession { get; set; }
        public int Salary { get; set; }
        public int SupervisorId { get; set; }
    }
}
