using CarWorkshop.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Repositories
{
    internal class CarWorkshopRepository : RepositoryBase, IRepository
    {
        public CarWorkshopRepository(string connectionString = null) : base(connectionString) { }

        public int GetCarsHandledCount(DateTime? dateTime = null)
        {
            using (var con = OpenConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("dateTime", dateTime, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                return con.QuerySingle<int>("GetCarsHandledCount", parameters, commandType: System.Data.CommandType.StoredProcedure);
            }
        }

        public Dictionary<int, int> GetCarsHandledCountByType(DateTime? from, DateTime? to)
        {
            using (var con = OpenConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("from", from, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                parameters.Add("to", to, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                var lookup = new Dictionary<int, int>();
                con.Query<int, int, int>("GetCarsHandledCountByType", 
                    (type, count) => 
                    {
                        int innerCount = 0;
                        if (!lookup.TryGetValue(type, out innerCount)) lookup.Add(type, innerCount = count);
                        return innerCount;
                    }, splitOn: "Count", param: parameters, commandType: System.Data.CommandType.StoredProcedure);
                return lookup;
            }
        }

        public Dictionary<int, int> GetEmployeesHours(DateTime? from, DateTime? to)
        {
            using (var con = OpenConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("from", from, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                parameters.Add("to", to, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                var lookup = new Dictionary<int, int>();
                con.Query<int, int, int>("GetEmployeesHours",
                    (employee, hours) =>
                    {
                        int innerHours = 0;
                        if (!lookup.TryGetValue(employee, out innerHours)) lookup.Add(employee, innerHours = hours);
                        return innerHours;
                    }, splitOn: "Hours", param: parameters, commandType: System.Data.CommandType.StoredProcedure);
                return lookup;
            }
        }

        public Dictionary<int, CountToCost> GetTopUsedPartsWithCost(DateTime? from, DateTime? to, int? top = 10)
        {
            using (var con = OpenConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("from", from, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                parameters.Add("to", to, System.Data.DbType.DateTime, System.Data.ParameterDirection.Input);
                parameters.Add("top", top, System.Data.DbType.Int32, System.Data.ParameterDirection.Input);
                var lookup = new Dictionary<int, CountToCost>();
                con.Query<int, CountToCost, CountToCost>("GetTopUsedPartsWithCost",
                    (part, ids) =>
                    {
                        CountToCost innerPair = null;
                        if (!lookup.TryGetValue(part, out innerPair)) lookup.Add(part, innerPair = ids);
                        return innerPair;
                    }, splitOn: "Count", param: parameters, commandType: System.Data.CommandType.StoredProcedure);
                return lookup;
            }
        }
    }
}
