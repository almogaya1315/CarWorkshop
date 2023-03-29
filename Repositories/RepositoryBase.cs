using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarWorkshop.Repositories
{
    internal abstract class RepositoryBase
    {
        private string _connectionString;

        public RepositoryBase(string connectionString)
        {
            _connectionString = connectionString;
        }
        public RepositoryBase()
        {
            GetLocalConnection();
        }

        protected SqlConnection OpenConnection()
        {
            if (string.IsNullOrWhiteSpace(_connectionString))
                GetLocalConnection();
            return new SqlConnection(_connectionString);
        }

        private void GetLocalConnection()
        {
            _connectionString = ConfigurationManager.AppSettings["LocalDb"];
        }
    }
}
