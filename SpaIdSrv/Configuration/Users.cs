using IdentityModel;
using IdentityServer4.Test;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace SpaIdSrv.Configuration
{
    public class Users
    {
        public static List<TestUser> GetUsers()
        {
            return new List<TestUser>
    {
        new TestUser{SubjectId = "818727", Username = "Michael", Password = "password",
                Claims =
                {
                    new Claim(JwtClaimTypes.Name, "Michael Boeynaems"),
                    new Claim(JwtClaimTypes.GivenName, "Michael"),
                    new Claim(JwtClaimTypes.FamilyName, "Boeynaems"),
                    new Claim(JwtClaimTypes.Email, "michael.boeynaems@colruytgroup.com"),
                    new Claim(JwtClaimTypes.EmailVerified, "true", ClaimValueTypes.Boolean),
                    new Claim(JwtClaimTypes.WebSite, "https://infosecmike.com"),
                    new Claim(JwtClaimTypes.Address, @"{ 'street_address': 'One Hacker Way', 'locality': 'Heidelberg', 'postal_code': 2450, 'country': 'Belgium' }", IdentityServer4.IdentityServerConstants.ClaimValueTypes.Json)
                }
            },
            new TestUser{SubjectId = "7265", Username = "Johan", Password = "password",
                Claims =
                {
                    new Claim(JwtClaimTypes.Name, "Johan Peeters"),
                    new Claim(JwtClaimTypes.GivenName, "Johan"),
                    new Claim(JwtClaimTypes.FamilyName, "Peeters"),
                    new Claim(JwtClaimTypes.Email, "yo@johanpeeters.com"),
                    new Claim(JwtClaimTypes.EmailVerified, "true", ClaimValueTypes.Boolean),
                    new Claim(JwtClaimTypes.WebSite, "https://www.johanpeeters.com"),
                    new Claim(JwtClaimTypes.Address, @"{ 'street_address': 'Two Hacker Way', 'locality': 'Heidelberg', 'postal_code': 3000, 'country': 'Belgium' }", IdentityServer4.IdentityServerConstants.ClaimValueTypes.Json),
                    new Claim("location", "somewhere"),
                }
            },
    };
        }
    }
}
