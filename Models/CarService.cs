using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Models
{
    public class CarService
    {
        public int Id { get; set; }
        public int CarLicenseNumber { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime? FinishTime { get; set; }
        public int StatusId { get; set; }
        public int AssignedEmployeeId { get; set; }
    }
}
