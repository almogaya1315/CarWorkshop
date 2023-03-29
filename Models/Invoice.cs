using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Models
{
    public class Invoice
    {
        public int RecietNumber { get; set; }
        public int CustomerId { get; set; }
        public int CarLicenseNumber { get; set; }
        public int ServiceId { get; set; }
    }
}
