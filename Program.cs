using CarWorkshop.Repositories;
using System;

namespace CarWorkshop
{
    class Program
    {
        static void Main(string[] args)
        {
            var workshop = new CarWorkshopRepository();
            var from = DateTime.Parse("1990-01-01");
            var to = DateTime.Parse("2022-01-01");
            var carCount = workshop.GetCarsHandledCount(DateTime.Parse("2001-01-27"));
            var typeToCount = workshop.GetCarsHandledCountByType(from, to);
            var topUsedParts = workshop.GetTopUsedPartsWithCost(from, to, 3);
            var employeesHours = workshop.GetEmployeesHours(from, to);
        }
    }
}
