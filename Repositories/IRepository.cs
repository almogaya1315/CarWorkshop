using CarWorkshop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Repositories
{
    internal interface IRepository
    {
        int GetCarsHandledCount(DateTime? dateTime = null);

        Dictionary<int, int> GetCarsHandledCountByType(DateTime? from, DateTime? to);

        Dictionary<int, CountToCost> GetTopUsedPartsWithCost(DateTime? from, DateTime? to, int? top = 10);

        Dictionary<int, int> GetEmployeesHours(DateTime? from, DateTime? to);
    }
}
