using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Models
{
    public class Car
    {
        public int LicenseNumber { get; set; }
        public int TypeId { get; set; }
        public int Model { get; set; }
        public int CustomerId { get; set; }
    }
}
