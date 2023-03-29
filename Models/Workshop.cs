using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Models
{
    public class Workshop : IdToName
    {
        public string Phone { get; set; }
        public string Address { get; set; }
        public int ManagerId { get; set; }
        public int WorkingHours { get; set; }
	}
}
