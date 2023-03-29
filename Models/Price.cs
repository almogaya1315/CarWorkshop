using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Models
{
    public class Price
    {
        public int Id { get; set; }
        public int CarLicenseNumber { get; set; }
        public int HourlyWorkRate { get; set; }
    }
}
