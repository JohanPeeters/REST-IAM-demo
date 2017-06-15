using IdentityServer4.Test;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SpaIdSrv.Configuration
{
    public class Users
    {
        public static List<TestUser> GetUsers()
        {
            return new List<TestUser>
    {
        new TestUser
        {
            SubjectId = "1",
            Username = "johan",
            Password = "password"
        },
        new TestUser
        {
            SubjectId = "2",
            Username = "michael",
            Password = "password"
        }
    };
        }
    }
}
